package com.glance.service.impl;

import com.glance.model.dto.ApiResponse;
import com.glance.model.dto.response.StoryResponse;
import com.glance.model.entity.GlanceStory;
import com.glance.model.entity.HeartCard;
import com.glance.model.entity.MatchRecord;
import com.glance.repository.GlanceStoryRepository;
import com.glance.repository.HeartCardRepository;
import com.glance.repository.MatchRecordRepository;
import com.glance.repository.UserRepository;
import com.glance.service.StoryService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class StoryServiceImpl implements StoryService {

    private final GlanceStoryRepository storyRepository;
    private final MatchRecordRepository matchRecordRepository;
    private final HeartCardRepository heartCardRepository;
    private final UserRepository userRepository;

    private static final Random RANDOM = new Random();

    /** 故事模板数组，{nickname} {scene} {seenCount} {matchCount} 为占位变量 */
    private static final String[][] TEMPLATES = {
        {"今天在{scene}，有 {seenCount} 个人注意到了你。其中 {matchCount} 个人和你互相标记了心意。",
         "或许其中就有那个让你回头的人。"},
        {"今天的你，被 {seenCount} 双眼睛悄悄关注过。\n有 {matchCount} 次，你们的目光在同一个方向停留。",
         "缘分有时就是如此巧合。"},
        {"{nickname}，今天是个特别的日子。\n在{scene}，有 {matchCount} 个人也在寻找像你这样的人。",
         "你从来都不是一个人。"},
        {"今天你在{scene}留下了 {seenCount} 次心跳的痕迹。\n其中 {matchCount} 次，对方也感受到了。",
         "这就是回眸的意义。"},
        {"又是美好的一天。{nickname}，{scene}里有 {seenCount} 个人注意到了你。",
         "每一次相遇都值得被记住。"},
        {"今天的{scene}很特别。{seenCount} 个陌生人与你擦肩，{matchCount} 次心照不宣。",
         "有些相遇，是注定的。"},
        {"{nickname}，你有没有发现——\n今天在{scene}，有人因为看到你而微笑。",
         "虽然你不知道是谁。"},
        {"今天的故事很安静：{scene}，{seenCount} 次注意，{matchCount} 次回应。",
         "安静有时是最美的语言。"},
        {"{nickname}，回眸提醒你：\n今天有 {seenCount} 个人在你的世界里短暂停留。",
         "珍惜每一次目光交汇。"},
        {"今天{scene}的风很温柔，有 {seenCount} 个人也因此多看了你一眼。",
         "也许下次，你们会鼓起勇气。"},
        {"{nickname}，今天的回眸记录：\n{scene}里出现了 {matchCount} 个心动的可能。",
         "不管结果如何，心动本身就很美好。"},
        {"今天{scene}的灯光下，{seenCount} 个路人中，有 {matchCount} 个人和你想的一样。",
         "这个城市，比你想象的更温暖。"},
    };

    @Override
    public ApiResponse<StoryResponse> getTodayStory(Long userId) {
        LocalDate today = LocalDate.now();

        // 已有今日故事则直接返回
        var existing = storyRepository.findByUserIdAndStoryDate(userId, today);
        if (existing.isPresent()) {
            return ApiResponse.ok(toResponse(existing.get()));
        }

        // 统计今天数据
        LocalDateTime todayStart = today.atStartOfDay();
        List<HeartCard> myCards = heartCardRepository.findByUserIdAndStatus(userId, 1);
        List<MatchRecord> matches = matchRecordRepository.findByUserAIdOrUserBId(userId, userId);
        long todayMatches = matches.stream()
                .filter(m -> m.getMatchedAt() != null && m.getMatchedAt().isAfter(todayStart))
                .count();
        int seenCount = myCards.size() + new Random().nextInt(10); // 模拟被关注数

        // 无互动则不生成
        if (myCards.isEmpty() && todayMatches == 0) {
            return ApiResponse.ok(null);
        }

        // 选模板 + 填充变量
        String[] template = TEMPLATES[RANDOM.nextInt(TEMPLATES.length)];
        String scene = myCards.isEmpty() ? "这个城市" : getSceneLabel(myCards.get(0).getScene());
        String nickname = userRepository.findById(userId)
                .map(u -> u.getNickname()).orElse("你");

        String content = template[0]
                .replace("{nickname}", nickname)
                .replace("{scene}", scene)
                .replace("{seenCount}", String.valueOf(seenCount))
                .replace("{matchCount}", String.valueOf(todayMatches))
            + "\n\n" + template[1];

        GlanceStory story = GlanceStory.builder()
                .userId(userId).content(content).storyDate(today).build();
        storyRepository.save(story);

        log.info("生成今日回眸故事: userId={}", userId);
        return ApiResponse.ok(toResponse(story));
    }

    @Override
    public ApiResponse<List<StoryResponse>> getStoryHistory(Long userId, int page, int size) {
        var pageResult = storyRepository.findByUserIdOrderByStoryDateDesc(
                userId, PageRequest.of(page, size));
        List<StoryResponse> list = pageResult.getContent().stream()
                .map(this::toResponse).collect(Collectors.toList());
        return ApiResponse.ok(list);
    }

    private StoryResponse toResponse(GlanceStory s) {
        return StoryResponse.builder()
                .id(s.getId()).content(s.getContent())
                .storyDate(s.getStoryDate()).createdAt(s.getCreatedAt().toString()).build();
    }

    private String getSceneLabel(String scene) {
        return switch (scene) {
            case "subway" -> "地铁"; case "library" -> "图书馆";
            case "cafe" -> "咖啡店"; case "campus" -> "校园";
            default -> "城市某处";
        };
    }
}
