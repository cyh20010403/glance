package com.glance.model.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "interest_tag")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InterestTag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 20, unique = true)
    private String name;

    @Column(length = 5)
    @Builder.Default
    private String emoji = "";

    @Column(length = 20)
    @Builder.Default
    private String category = "";

    @Column(name = "sort_order")
    @Builder.Default
    private Integer sortOrder = 0;
}
