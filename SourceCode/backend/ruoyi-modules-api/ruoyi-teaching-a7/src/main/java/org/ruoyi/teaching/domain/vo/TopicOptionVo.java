package org.ruoyi.teaching.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.teaching.domain.TopicOption;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = TopicOption.class)
public class TopicOptionVo implements Serializable {

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
     * 创建时间
     */
    private Date createTime;

    /**
     * 是否是正确答案
     */
    private Boolean rightAnswer;
}