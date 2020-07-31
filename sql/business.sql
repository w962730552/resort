-- ----------------------------
-- 1、单据表
-- ----------------------------
drop table if exists bill;
create table bill (
  bill_id             bigint(20) not null auto_increment          comment   '单据号',
  bill_channel      char(1)    not null                       comment  '单据产生渠道 1、系统推送 2、人工上报',
  bill_type         char(1)    not null                       comment  '单据类别 1、交通预警 2、客流预警 3、气象预警 4、游乐设施故障 5、其他',
  bill_status  			char(1)	     not null                      comment  '案件状态 1、未处理 2、处理中 3、完成',
  bill_title        varchar(24)   not null                        comment    '单据标题',
  bill_info         varchar(2000)   not null                        comment   '案件信息',
  bill_supplement   varchar(2000)                          comment   '补充说明',
  primary key (bill_id)
) engine=innodb auto_increment=1 comment = '单据表';
insert into bill VALUES (1,'1','1','1','停车场预警','P6停车场停车量已达到85%警戒线',null,1,'2020-07-29 14-37-00');
insert into bill VALUES (2,'1','3','1','暴雨黄色预警','上海市浦东新区气象台2020年07月06日10时17分更新暴雨蓝色预警信号为暴雨...',null,1,'2020-07-29 14-37-00');
insert into bill VALUES (3,'1','2','1','客流预警，迪士尼核心区人员已达20000人，请相关人员提前准备，做好服务。',null,1,'2020-07-29 14-37-00');
-- ----------------------------
-- 2、流程定义表
-- ----------------------------
drop table if exists flow;
Create table flow(
	      flow_id bigint(20) not null auto_increment  comment  '环节定义id',
        flow_name varchar(50) not null comment '环节定义名称',
	      Parent_id bigint(20)   comment  '父节点',
	      status  varchar(10)   not null comment    '状态',
        flow_define comment varchar(50) not null '流程定义',
primary key (flow_id)
)engine=innodb auto_increment=1 comment = '流程定义表'
insert into flow values(1,'信息上报',null,'emergency','begin');
insert into flow values(2,'协调处理',1,'emergency','between');
insert into flow values(3,'录入处置情况',2,'emergency','between');
insert into flow values(4,'关闭工单',3,'emergency','end');
-- ----------------------------
-- 3、环节处理表
-- ----------------------------
drop table if exists link;
Create table link(
        bill_id     bigint(20) not null comment    '单据号',
        flow_id     bigint(20) not null comment     '环节定义id',
        create_time  datetime not null comment  '创建时间',
        link_info   varchar(2000)  comment  '环节处理信息',
        complete_time datetime comment '完成时间',
        user_id      bigint(20) comment    '处理人',
        primary key (bill_id,flow_id)
)engine=innodb auto_increment=1 comment = '环节处理表'


-- ----------------------------
-- 4、交办表
-- ----------------------------
drop table if exists assignment;
Create table assignment(
        bill_id     bigint(20) not null comment    '单据号',
        user_id  bigint(20) not null comment '用户id',
        primary key(bill_id,user_id)
)engine=innodb comment = '交办表'

-- ----------------------------
-- 5、环节处理督办表
-- ----------------------------
drop table if exists supervise;
Create table supervise(
        supervise_id    bigint(20)      not null auto_increment                  comment   '督办id',
        supervise_info  varchar(2000)    not null                     comment '督办信息',
        bill_id     bigint(20) not null comment    '单据号',
	      flow_id     bigint(20) not null comment     '环节定义id',
        user_id        bigint(20)     not null                 comment '创建者',
        create_time      datetime       not null                   comment '创建时间',
        parent_user_id   bigint(20)                                     comment   '回复的谁',
primary key (supervise_id)
)engine=innodb auto_increment=1 comment = '环节督办表'

-- ----------------------------
-- 6、模块表
-- ----------------------------
drop table if exists sys_modular;
Create table sys_modular(
        modular_id    bigint(20)      not null auto_increment                  comment   '督办id',
        modular_name  varchar(100)    not null                     comment '督办信息',
        create_by     bigint(20)  comment '创建者',
        create_time   datetime    comment '创建时间',
        update_by     bigint(20)  comment '修改者',
        update_time   datetime    comment '修改时间',
        remark        varchar(100) comment '备注',
primary key (modular_id)
)engine=innodb auto_increment=1 comment = '环节督办表'

-- ----------------------------
-- 7、案件用户查看表
-- ----------------------------
drop table if exists lookup;
Create table lookup(
        lookup_id bigint(20)      not null auto_increment                  comment   '案件查看id',
        bill_id     bigint(20) not null comment    '单据号',
        user_id        bigint(20)     not null                 comment '用户id',
        create_time    datetime      not null comment '创建时间',
primary key ()
)engine=innodb auto_increment=1 comment = '案件用户查看表'