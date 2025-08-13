package org.ruoyi.teaching.domain;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.math.BigDecimal;

/**
 * 视频课程对象 b4_video_course
 *
 * @author baoyu
 * @date 2025-07-04
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("b4_video_course")
public class VideoCourse extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 部门ID
     */
    @TableId(value = "id")
    private Long id;

    /**
     * 视频名称
     */
    private String videoName;

    /**
     * 视频类型
     */
    private String videoType;

    /**
     * 视频大小
     */
    private Long videoSize;

    /**
     * 视频大小
     */
    private String formattedSize;

    /**
     * 视频时常
     */
    private BigDecimal videoDuration;

    /**
     * 视频时常
     */
    private String formattedDuration;

    /**
     * 收藏
     */
    private Boolean collection;
}
