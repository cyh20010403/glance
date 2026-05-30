package com.glance.controller;

import com.glance.model.dto.ApiResponse;
import com.glance.model.entity.BlockList;
import com.glance.model.entity.Report;
import com.glance.repository.BlockListRepository;
import com.glance.repository.ReportRepository;
import com.glance.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final BlockListRepository blockListRepository;
    private final ReportRepository reportRepository;

    /** 获取用户匿名资料（匹配后展示） */
    @GetMapping("/{id}/profile")
    public ApiResponse<?> getProfile(@PathVariable Long id) {
        var user = userService.getUserById(id);
        if (user == null) return ApiResponse.error("用户不存在");
        return ApiResponse.ok(Map.of(
            "nickname", user.getNickname(),
            "gender", user.getGender(),
            "age", user.getAge(),
            "tags", user.getTags() != null ? user.getTags() : "",
            "signature", user.getSignature()
        ));
    }

    /** 获取自己的形象设置 */
    @GetMapping("/my-look")
    public ApiResponse<?> getMyLook(Authentication auth) {
        Long userId = (Long) auth.getPrincipal();
        var user = userService.getUserById(userId);
        if (user == null) return ApiResponse.error("用户不存在");
        return ApiResponse.ok(Map.of(
            "myTopColor", user.getMyTopColor(),
            "myPantsColor", user.getMyPantsColor(),
            "myShoeColor", user.getMyShoeColor(),
            "myHairstyle", user.getMyHairstyle(),
            "myGlasses", user.getMyGlasses(),
            "myHasBag", user.getMyHasBag()
        ));
    }

    /** 更新我的形象 */
    @PutMapping("/my-look")
    public ApiResponse<?> updateMyLook(Authentication auth,
                                        @RequestBody Map<String, Object> body) {
        Long userId = (Long) auth.getPrincipal();
        return userService.updateMyLook(userId, body);
    }

    @PutMapping("/profile")
    public ApiResponse<?> updateProfile(Authentication auth,
                                         @RequestBody Map<String, Object> body) {
        Long userId = (Long) auth.getPrincipal();
        return userService.updateProfile(userId,
                (String) body.get("nickname"),
                (String) body.get("avatar"),
                (String) body.get("signature"),
                (List<String>) body.get("tags"));
    }

    @PostMapping("/block/{targetId}")
    public ApiResponse<?> blockUser(Authentication auth, @PathVariable Long targetId) {
        Long userId = (Long) auth.getPrincipal();
        if (blockListRepository.existsByUserIdAndBlockedId(userId, targetId)) {
            return ApiResponse.error("已拉黑该用户");
        }
        BlockList block = BlockList.builder().userId(userId).blockedId(targetId).build();
        blockListRepository.save(block);
        return ApiResponse.ok("已拉黑");
    }

    @PostMapping("/report/{targetId}")
    public ApiResponse<?> reportUser(Authentication auth, @PathVariable Long targetId,
                                      @RequestParam String reason,
                                      @RequestParam(required = false) String detail) {
        Long userId = (Long) auth.getPrincipal();
        Report report = Report.builder()
                .reporterId(userId).targetId(targetId)
                .reason(reason).detail(detail != null ? detail : "")
                .build();
        reportRepository.save(report);
        return ApiResponse.ok("举报已提交");
    }
}
