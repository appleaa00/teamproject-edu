package org.ruoyi.teaching.domain;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 试卷信息对象
 *
 * @author baoyu
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("a7_paper_user_relation")
public class PaperUserRelation extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId
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
     * 完成时间（单位：分钟）
     */
    private Integer finishTime;
}
