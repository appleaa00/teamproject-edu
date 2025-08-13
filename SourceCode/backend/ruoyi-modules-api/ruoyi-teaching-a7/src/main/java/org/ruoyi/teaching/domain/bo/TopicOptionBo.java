package org.ruoyi.teaching.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.teaching.domain.TopicOption;

import java.io.Serial;

@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = TopicOption.class, reverseConvertGenerate = false)
public class TopicOptionBo extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
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