package org.ruoyi.teaching.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.teaching.domain.PaperAnswer;

import java.io.Serial;

/**
 * 试卷答案业务对象 a7_paper_answer
 *
 * @author baoyu
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = PaperAnswer.class, reverseConvertGenerate = false)
public class PaperAnswerBo extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @NotNull(message = "ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 试卷ID
     */
    @NotNull(message = "试卷ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long paperId;

    /**
     * 题目ID
     */
    @NotNull(message = "题目ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long topicId;

    /**
     * 填写答案
     */
    @NotBlank(message = "填写答案不能为空", groups = { AddGroup.class, EditGroup.class })
    private String topicWrite;

    /**
     * 是否正确
     */
    private Boolean rightAnswer;
}