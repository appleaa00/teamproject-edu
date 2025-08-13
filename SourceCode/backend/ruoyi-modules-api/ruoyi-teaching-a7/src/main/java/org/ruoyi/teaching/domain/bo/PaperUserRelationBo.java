package org.ruoyi.teaching.domain.bo;

import io.github.linpeilie.annotations.AutoMapper;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.teaching.domain.PaperUserRelation;

import java.io.Serial;
import java.util.List;

/**
 * 试卷用户关系业务对象 a7_paper_user_relation
 *
 * @author baoyu
 */
@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = PaperUserRelation.class, reverseConvertGenerate = false)
public class PaperUserRelationBo extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @NotNull(message = "ID不能为空", groups = { EditGroup.class })
    private Long id;

    /**
     * 试卷ID
     */
    @NotNull(message = "试卷ID不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long paperId;

    /**
     * 考试人
     */
    @NotNull(message = "考试人不能为空", groups = { AddGroup.class, EditGroup.class })
    private Long userId;

    /**
     * 是否完成（默认false）
     */
    private Boolean finished;

    /**
     * 完成时间
     */
    private Integer finishTime;

    private List<PaperAnswerBo> paperAnswerBoList;
}