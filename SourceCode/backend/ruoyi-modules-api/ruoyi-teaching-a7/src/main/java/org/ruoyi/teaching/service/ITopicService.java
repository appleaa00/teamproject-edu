package org.ruoyi.teaching.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.teaching.domain.Topic;
import org.ruoyi.teaching.domain.bo.TopicBo;
import org.ruoyi.teaching.domain.vo.TopicVo;

import java.util.Collection;
import java.util.List;

/**
 * Service接口
 *
 * @author baoyu
 */
public interface ITopicService extends IService<Topic> {

    /**
     * 查询题目
     */
    TopicVo queryById(Long id);

    /**
     * 查询题目列表
     */
    TableDataInfo<TopicVo> queryPageList(TopicBo bo, PageQuery pageQuery);

    /**
     * 查询题目列表
     */
    List<TopicVo> queryList(TopicBo bo);
    List<TopicVo> queryByPaperId(Long paperId);

    /**
     * 新增题目
     */
    Boolean insertByBo(TopicBo bo);

    /**
     * 修改题目
     */
    Boolean updateByBo(TopicBo bo);

    /**
     * 校验并批量删除题目信息
     */
    Boolean deleteWithValidByIds(Collection<Long> ids, Boolean isValid);

    /**
     * 删除题目
     */
    void removeEntity(Long id);
}