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
@TableName("a7_paper_answer")
public class PaperAnswer extends BaseEntity {

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
}
