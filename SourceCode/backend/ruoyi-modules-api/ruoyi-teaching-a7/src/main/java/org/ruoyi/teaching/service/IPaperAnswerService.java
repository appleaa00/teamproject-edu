package org.ruoyi.teaching.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.PaperAnswer;
import org.ruoyi.teaching.domain.bo.PaperAnswerBo;
import org.ruoyi.teaching.domain.vo.PaperAnswerVo;

import java.util.Collection;
import java.util.List;

/**
 * 试卷答案Service接口
 *
 * @author baoyu
 */
public interface IPaperAnswerService extends IService<PaperAnswer> {

    /**
     * 查询试卷答案
     */
    PaperAnswerVo queryById(Long id);

    /**
     * 查询试卷答案列表
     */
    TableDataInfo<PaperAnswerVo> queryPageList(PaperAnswerBo bo, PageQuery pageQuery);

    /**
     * 查询试卷答案列表
     */
    List<PaperAnswerVo> queryList(PaperAnswerBo bo);

    /**
     * 新增试卷答案
     */
    Boolean insertByBo(PaperAnswerBo bo);

    /**
     * 修改试卷答案
     */
    Boolean updateByBo(PaperAnswerBo bo);

    /**
     * 校验并批量删除试卷答案信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 根据试卷ID和题目ID查询答案
     */
    PaperAnswerVo queryByPaperIdAndTopicId(Long paperId, Long topicId);

    /**
     * 根据试卷ID查询所有答案
     */
    List<PaperAnswerVo> queryByPaperId(Long paperId);
}