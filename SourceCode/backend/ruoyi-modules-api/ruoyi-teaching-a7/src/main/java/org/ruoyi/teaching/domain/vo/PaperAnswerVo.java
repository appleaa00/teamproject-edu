package org.ruoyi.teaching.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.teaching.domain.PaperAnswer;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 试卷答案视图对象 a7_paper_answer
 *
 * @author baoyu
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = PaperAnswer.class)
public class PaperAnswerVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    private Long id;

    /**
     * 试卷ID
     */
    private Long paperId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 题目ID
     */
    private Long topicId;

    /**
     * 填写答案
     */
    private String topicWrite;

    /**
     * 是否正确
     */
    private Boolean rightAnswer;

    /**
     * 创建时间
     */
    private Date createTime;
}