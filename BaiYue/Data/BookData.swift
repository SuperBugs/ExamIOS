//
//  BookJiChuData.swift
//  BaiYue
//
//  Created by qcj on 2017/12/14.
//  Copyright © 2017年 qcj. All rights reserved.
//

import Foundation
class BookData{
    var mBookJiChuStartPageArr=[7,9,15,15,15,2,3,3,4,3,4]//章节起始页数
    var mBookJiChuCatalogArr=["前言",
                              "目录",
                              "第一章",
                              "概述",
                              " 第一节 公路水运工程试验检测起源与发展",
                              " 第二节 公路水运工程试验检测的作用",
                              "第二章",
                              "公路水运工程试验检测管理相关的法律法规",
                              " 第一节 计量法及计量法实施细则有关内容",
                              " 第二节 标准化法及标准化法实施条例有关内容",
                              " 第三节 产品质量法",
                              " 第四节 建设工程质量管理条例",
                              "第三章",
                              " 公路水运工程试验检测管理",
                              " 第一节 《公路水运工程试验检测管理办法》简介",
                              " 第二节 公路水运工程试验检测机构等级标准和等级评定程序",
                              " 第三节 公路水运工程试验检测机构和人员信用评价",
                              " 第四节 公路水运工程工地试验室管理",
                              " 第五节 公路水运工程试验检测机构的换证管理",
                              " 第六节 公路水运工程试验检测人员的继续教育",
                              " 第七节 公路水运工程试验检测的安全管理",
                              " 第八节 试验检测记录与报告的管理要求",
                              "第四章",
                              "公路水运工程试验检测人员考试管理",
                              " 第一节 公路水运工程试验检测人员考试制度发展历程",
                              " 第二节 试验检测人员职业资格考试专业及科目设置",
                              " 第三节 试验检测人员职业资格考试管理",
                              "第五章",
                              "检验检测机构资质认定管理",
                              " 第一节 检验检测机构资质认定管理办法简介",
                              " 第二节 检验检测机构资质认定评审准则与管理体系文件构成",
                              " 第三节 《检测和校准实验室能力认可准则》的概要",
                              " 第四节 印章的分类与使用",
                              " 第五节 检验检测机构运行中的常见问题",
                              "第六章",
                              "试验检测常用术语和定义",
                              " 第一节 试验检测管理术语",
                              " 第二节 试验检测技术术语",
                              "第七章",
                              "法定计量单位",
                              " 第一节 国际单位制",
                              " 第二节 SI单位及其倍数单位的应用",
                              " 第三节 SI基本单位的定义",
                              "第八章",
                              "数值修约规则与极限数值的表示和判定、测量误差与测量不确定度",
                              " 第一节 数值修约规则",
                              " 第二节 极限数值的表示和判定",
                              " 第三节 测量误差与测量不确定度",
                              "第九章",
                              "能力验证",
                              " 第一节 能力验证的基本概念",
                              " 第二节 能力验证计划的类型",
                              " 第三节 能力验证计划的设计与实施步骤",
                              " 第四节 能力验证结果的统计处埋和能力评价",
                              "第十章",
                              "统计技术和抽样技术",
                              " 第一节 统计技术的基础",
                              " 第二节 常用数理统计工具",
                              " 第三节 抽样技术及应用",
                              "第十一章",
                              "仪器设备计量溯源及期间核查",
                              " 第一节 仪器设备计量溯源",
                              " 第二节 计量结果的确认及运用",
                              " 第三节 校准数据的线性回归",
                              " 第四节 期间核查",
                              "附录1建设工程质量管理条例",
                              "附录2公路水运工程试验检测管理办法",
                              "附录3公路水运工程试验检测机构等级标准与评定程序",
                              ]//章节数
}
/*
目    录
第一篇概  述
第一章概述……    ………．3
第一节公路水运工程试验检测起源与发展……-3
第二节公路水运工程试验检测的作用…………-5
第二篇公路水运工程试验检测管理
第二章公路水运工程试验检测管理相关的法律法规……．    ………一-9
第一节计量法及计量法实施细则有关内容”…．    ………-9
第二节标准化法及标准化法实施条例有关内容………    ……“13
第三节产品质量法…．i…一16
第四节建设工程质量管理条例………    …- 17
第三章公路水运工程试验检测管理……    ………“- 20
第一节《公路水运工程试验检测管理办法》简介………    ………“- 20
第二节公路水运工程试验检测机构等级标准和等级评定程序…………- 24
第三节公路水运工程试验检测机构和人员信用评价…    ………“- 39
第四节公路水运工程工地试验室管理………-- 47
第五节公路水运工程试验检测机构的换证管理………    ……“51
第六节公路水运工程试验检测人员的继续教育………    ………“- 55
第七节公路水运工程试验检测的安全管理…-- 58
第八节试验检测记录与报告的管理要求……-    ………．．    …- 61
第四章公路水运工程试验检测人员考试管理…．    ……一82
第一节公路水运工程试验检测人员考试制度发展历程…～…．    …- 82
第二节试验检测人员职业资格考试专业及科目设置…    ………“- 83
第三节试验检测人员职业资格考试管理……．    ……一85
第五章检验检测机构资质认定管理……- 89
第一节检验检测机构资质认定管理办法简介．    ………“- 89
第二节检验检测机构资质认定评审准则与管理体系文件构成…………    ……一96
第三节《检测和校准实验室能力认可准则》的概要…．- 122
第四节印章的分类与使用……    ………-- 126
-1一
*/
