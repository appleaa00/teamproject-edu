package org.ruoyi.teaching.domain.bo;


import io.github.linpeilie.annotations.AutoMapper;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.teaching.domain.VideoCourse;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serial;
import java.math.BigDecimal;
import java.util.Date;

@Data
@EqualsAndHashCode(callSuper = true)
@AutoMapper(target = VideoCourse.class, reverseConvertGenerate = false)
public class VideoCourseBo extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
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

    /**
     * 最近保存
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startCreateTime;
}
