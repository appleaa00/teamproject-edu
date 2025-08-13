package org.ruoyi.teaching.domain;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 试卷信息对象 a7_paper
 *
 * @author baoyu
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("a7_paper")
public class Paper extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId
    private Long id;

    /**
     * 试卷名称
     */
    private String paperName;

    /**
     * 当前试卷是什么角色的人创建的
     */
    private String createRole;

    /**
     * 创建人姓名
     */
    private String createName;

    /**
     * 测验难度（基础、中等、挑战）
     */
    private String paperDifficulty;

    /**
     * 试卷类型（全部题型、编程题、选择题）
     */
    private String paperType;

    /**
     * 科目：计算机科学与技术
     */
    private String paperSubject;

    /**
     * 题目数量
     */
    private Integer topicNumber;

    /**
     * 答题时间（单位：分钟）
     */
    private Integer answerTime;

    /**
     * 收藏
     */
    private Boolean collection;
}
