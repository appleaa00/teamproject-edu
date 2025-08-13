package org.ruoyi.teaching.domain;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 试卷题目选项
 *
 * @author baoyu
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("a7_topic_option")
public class TopicOption extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 部门ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 所属题目ID
     */
    private Long topicId;

    /**
     * 排序，选择题则以1、2、3或者A、B、C去录入
     */
    private String sorted;

    /**
     * 选项内容
     */
    private String optionContent;

    /**
     * 是否是正确答案
     */
    private Boolean rightAnswer;
}
