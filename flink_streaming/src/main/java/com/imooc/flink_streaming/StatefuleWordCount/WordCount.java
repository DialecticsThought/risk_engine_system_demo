package com.imooc.flink_streaming.StatefuleWordCount;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description
 * @Author veritas
 * @Data 2025/1/14 16:08
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class WordCount {

    /**
     * 单词
     */
    String word;
    /**
     * 每个单词の数量
     */
    Integer count;
}
