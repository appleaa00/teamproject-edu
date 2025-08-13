package org.ruoyi.teaching.domain.vo;

import com.alibaba.excel.annotation.ExcelIgnoreUnannotated;
import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import org.ruoyi.teaching.domain.PaperUserRelation;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

/**
 * 试卷用户关系视图对象 a7_paper_user_relation
 *
 * @author baoyu
 */
@Data
@ExcelIgnoreUnannotated
@AutoMapper(target = PaperUserRelation.class)
public class PaperUserRelationVo implements Serializable {

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
     * 考试人
     */
    private Long userId;

    /**
     * 是否完成（默认false）
     */
    private Boolean finished;

    /**
     * 完成时间
     */
    private Integer finishTime;

    /**
     * 创建时间
     */
    private Date createTime;
}