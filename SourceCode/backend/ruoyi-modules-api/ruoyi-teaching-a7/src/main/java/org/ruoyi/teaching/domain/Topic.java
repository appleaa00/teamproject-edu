package org.ruoyi.teaching.domain;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 试题
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("a7_topic")
public class Topic extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId
    private Long id;

    /**
     * 关联试卷ID
     */
    private Long paperId;

    /**
     * 题目名称
     */
    private String topicName;

    /**
     * 题目难度 基础、中等、挑战
     */
    private String topicDifficulty;

    /**
     * 题目类型 选择题、编程题
     */
    private String topicType;

    /**
     * 题目内容
     */
    private String topicContent;

    /**
     * 参考答案
     */
    private String topicAnswer;

    /**
     * 收藏
     */
    private Boolean collection;
}
