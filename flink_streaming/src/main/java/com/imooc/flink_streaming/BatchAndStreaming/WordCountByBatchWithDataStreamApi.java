package com.imooc.flink_streaming.BatchAndStreaming;

import org.apache.flink.api.common.functions.FlatMapFunction;
import org.apache.flink.api.common.functions.MapFunction;
import org.apache.flink.api.java.functions.KeySelector;
import org.apache.flink.api.java.tuple.Tuple2;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;

/**
 * @Description TODO 使用 dataStream api 批处理的方式词频统计
 * @Author veritas
 * @Data 2025/1/14 11:38
 */
public class WordCountByBatchWithDataStreamApi {

    public static void main(String[] args) throws Exception {
        //加载环境（加载的是流计算的上下文环境）
        StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();
        // source 加载数据
        DataStream<String> line = env.fromElements("imooc hadoop flink",
                "imooc hadoop flink",
                "imooc haddop",
                "imooc");
        // transformation
        /* *************************************
         * wordcount的步骤：分割，标记，相同的单词 分在一个组，每个组里的值聚合
         * 这里会涉及 Flink 的重要算子：map 和 flatMap, 以及 Flink 的 Tuple 类型
         *
         * map算子：将输入转换为另一种数据（例如将小写转换为大写）
         * flatMap算子：将一个输入转换为0-N条数据输出
         * Tuple 是 Flink 内置的元组类型
         * Tuple2 是二元组，Tuple3 是三元组
         *
         * **************************************
         */

        // 第一个泛型是输入的数据类型 第二个是输出的数据类型
        DataStream<String> wordDS = line.flatMap(new FlatMapFunction<String, String>() {
            @Override
            public void flatMap(String input, Collector<String> output) throws Exception {
                // 以 空格 进行 单词的分割 将每一行 分割出来的 单词放入数组
                String[] words = input.split(" ");
                for (String word : words) {
                    // 调用collector.collect方法输出
                    output.collect(word);
                }
            }
        });
        // 将分割出来的单词进行标记为1 表示这个单词 数量1个 输出tuple
        DataStream<Tuple2<String, Integer>> worDS = wordDS.map(new MapFunction<String, Tuple2<String, Integer>>() {

            @Override
            public Tuple2<String, Integer> map(String input) throws Exception {
                return Tuple2.of(input, 1);
            }
        });

        // 对标记后的单词 进行 分组
        // 返回值 的第一个泛型是 需要被分组的数据类型  第二个泛型是按照 某个key分组的话 key的数据类型
        KeyedStream<Tuple2<String, Integer>, Object> groupBy = worDS.keyBy(new KeySelector<Tuple2<String, Integer>, Object>() {
            @Override
            public Object getKey(Tuple2<String, Integer> stringIntegerTuple2) throws Exception {
                return stringIntegerTuple2.f0;
            }
        });

        // 求和
        SingleOutputStreamOperator<Tuple2<String, Integer>> sum = groupBy.sum(1);

        // sink
        sum.print();
        // 执行
        env.execute();
    }
}
