package com.imooc.flink_streaming.StatefuleWordCount;

import org.apache.flink.api.common.functions.RichFlatMapFunction;
import org.apache.flink.api.common.state.ValueState;
import org.apache.flink.api.common.state.ValueStateDescriptor;
import org.apache.flink.api.common.typeinfo.TypeInformation;
import org.apache.flink.configuration.Configuration;
import org.apache.flink.streaming.api.datastream.DataStream;
import org.apache.flink.streaming.api.datastream.DataStreamSource;
import org.apache.flink.streaming.api.datastream.KeyedStream;
import org.apache.flink.streaming.api.datastream.SingleOutputStreamOperator;
import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.Collector;
import org.graalvm.compiler.word.Word;

/**
 * @Description
 * @Author veritas
 * @Data 2025/1/14 16:05
 */
public class WordCountWithState {
    public static void main(String[] args) throws Exception {
        StreamExecutionEnvironment executionEnvironment = StreamExecutionEnvironment.getExecutionEnvironment();

        DataStreamSource<String> line = executionEnvironment.socketTextStream("localhost", 9999, "\n");

        // 第一个泛型是输入的数据类型 第二个是输出的数据类型
        //TODO 这里的collector的泛型是wordCount对象
        DataStream<WordCount> wordDS = line.flatMap((String input, Collector<WordCount> output) -> {
            String[] words = input.split(" ");
            for (String word : words) {
                // 将分割出来的单词进行标记为1 表示这个单词 数量1个 代替tuple
                output.collect(new WordCount(word, 1));
            }// 用 return 来制定返回的类型
        }).returns(WordCount.class);

        // 对标记后的单词 进行 分组
        // 返回值 的第一个泛型是 需要被分组的数据类型  第二个泛型是按照 某个key分组的话 key的数据类型

        /* **********************
         *
         * 知识点：
         *
         * keyBy 将DataStream转换为KeyedStream,KeyedStream是特殊的DataStream。
         *
         * Flink的状态分为：KeyedState和OperatorState，
         * KeyedState只能应用于KeyedStream，
         * 所以KeyedState的计算只能放在KeyBy之后
         *
         * *********************/
        KeyedStream<WordCount, Object> groupBy = wordDS.keyBy(wordCount -> {
            return wordCount.getWord();
        });
        // 状态计算
        SingleOutputStreamOperator<WordCount> sum = groupBy.sum(1);
        // sink
        sum.print();
        // 执行
        executionEnvironment.execute();
    }
}

/**
 * keysState的计算步骤
 * 1.继承Rich函数
 * 2. 重写Open方法 对state变量初始化
 * 3.状态计算逻辑
 * <p>
 * 为什么要进行有状态的计算 ？
 * 如果Flink发生了异常退出,checkpoint机制可以读取保存的状态()自己定义的，进行恢复。
 * <p>
 * 什么是Flink的状态 ？
 * 状态其实是个变量，这个变量保存了数据流的历史数据,
 * 如果有新的数据流进来，会读取状态变量，将新的数据和历史一起计算.
 * <p>
 * TODO keyBy之后，每个key都有对应的状态，同一个key只能操作自己对应的状态。（☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆）
 * <p>
 * TODO 实现接口的形参是 输入的数据的类型 和输出的collector的数据的类型
 */
class WordCountStateFunc extends RichFlatMapFunction<WordCount, WordCount> {
    // TODO 自己定义的状态变量
    /* **********************
     *
     * KeyedState的数据类型有：
     * ValueState<T>: 状态的数据类型为单个值，这个值是类型T
     * ListState<T>: 状态的数据类型为列表，列表值是类型T
     *
     * *********************/
    private ValueState<WordCount> keyedState;

    @Override
    public void open(Configuration parameters) throws Exception {
        // 传入 描述器的名称
        // 传入 描述器的数据类型
        // Flink有自己的一套数据类型，包含了JAVA和Scala的所有数据类型
        // 这些数据类型都是TypeInformation对象的子类。
        // TypeInformation对象统一了所有数据类型的序列化实现
        ValueStateDescriptor<WordCount> wordCountValueStateDescriptor =
                new ValueStateDescriptor<WordCount>("wordcountstate", TypeInformation.of(WordCount.class));
        // TODO 生成一个状态 并赋值给状态变量
        keyedState = getRuntimeContext().getState(wordCountValueStateDescriptor);
    }

    @Override
    public void flatMap(WordCount input, Collector<WordCount> collector) throws Exception {
        // 读取状态
        WordCount lastKeyedState = keyedState.value();

        // 更新状态
        if (lastKeyedState != null) {
            // 有状态 ，那么基于原有状态生成新的数据 并赋值给状态 也就是更新
            int i = lastKeyedState.getCount() + input.getCount();

            WordCount wordCount = new WordCount(input.word, i);

            keyedState.update(input);
            //返回数据
            collector.collect(input);
        } else {// 状态是空的直接赋值
            keyedState.update(input);
            //返回数据
            collector.collect(input);
        }
    }
}
