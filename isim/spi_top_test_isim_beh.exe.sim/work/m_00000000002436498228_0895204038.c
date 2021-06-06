/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/hajna/Documents/RendszerArchitekturakHF/spi_top_test.v";
static unsigned int ng1[] = {1U, 0U};
static unsigned int ng2[] = {15U, 0U};
static unsigned int ng3[] = {0U, 0U};
static const char *ng4 = "%t: SPI write - address=0x%h, data=0x%h";
static const char *ng5 = "%t: SPI read - address=0x%h, data=0x%h";
static int ng6[] = {0, 0};
static unsigned int ng7[] = {4U, 0U};
static unsigned int ng8[] = {20U, 0U};
static unsigned int ng9[] = {8U, 0U};
static unsigned int ng10[] = {16U, 0U};
static unsigned int ng11[] = {145U, 0U};
static unsigned int ng12[] = {24U, 0U};
static unsigned int ng13[] = {169U, 0U};
static unsigned int ng14[] = {2U, 0U};
static unsigned int ng15[] = {235U, 0U};
static unsigned int ng16[] = {3U, 0U};
static unsigned int ng17[] = {175U, 0U};

static void NetReassign_89_2(char *);


static int sp_apb_write32(char *t1, char *t2)
{
    char t8[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 848);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(51, ng0);

LAB5:    xsi_set_current_line(52, ng0);
    t5 = (t2 + 88U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    xsi_wp_set_status(t7, 1);
    *((char **)t3) = &&LAB6;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(53, ng0);
    t4 = (t1 + 4872);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3272);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 16);
    xsi_set_current_line(54, ng0);
    t4 = (t1 + 5032);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3592);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 32);
    xsi_set_current_line(55, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 3432);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(56, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 3752);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(57, ng0);
    t4 = ((char*)((ng2)));
    t5 = (t1 + 4072);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(58, ng0);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 16U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(59, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 3912);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(60, ng0);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(61, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 3752);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(62, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 3912);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(63, ng0);
    t4 = xsi_vlog_time(t8, 1000.0000000000000, 1000.0000000000000);
    t5 = (t1 + 4872);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t1 + 5032);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t1 + 848);
    xsi_vlogfile_write(1, 0, 0, ng4, 4, t12, (char)118, t8, 64, (char)118, t7, 16, (char)118, t11, 32);
    goto LAB4;

}

static int sp_apb_read32(char *t1, char *t2)
{
    char t8[16];
    int t0;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    t0 = 1;
    t3 = (t2 + 48U);
    t4 = *((char **)t3);
    if (t4 == 0)
        goto LAB2;

LAB3:    goto *t4;

LAB2:    t4 = (t1 + 1280);
    xsi_vlog_subprogram_setdisablestate(t4, &&LAB4);
    xsi_set_current_line(69, ng0);

LAB5:    xsi_set_current_line(70, ng0);
    t5 = (t2 + 88U);
    t6 = *((char **)t5);
    t7 = (t6 + 0U);
    xsi_wp_set_status(t7, 1);
    *((char **)t3) = &&LAB6;

LAB1:    return t0;
LAB4:    xsi_vlog_dispose_subprogram_invocation(t2);
    t4 = (t2 + 48U);
    *((char **)t4) = &&LAB2;
    t0 = 0;
    goto LAB1;

LAB6:    xsi_set_current_line(71, ng0);
    t4 = (t1 + 5192);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t7 = (t1 + 3272);
    xsi_vlogvar_assign_value(t7, t6, 0, 0, 16);
    xsi_set_current_line(72, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 3752);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 3432);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(74, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 4072);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 4);
    xsi_set_current_line(75, ng0);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 16U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(76, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t1 + 3912);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(77, ng0);
    t4 = (t2 + 88U);
    t5 = *((char **)t4);
    t6 = (t5 + 32U);
    xsi_wp_set_status(t6, 1);
    *((char **)t3) = &&LAB8;
    goto LAB1;

LAB8:    xsi_set_current_line(78, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 3752);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(79, ng0);
    t4 = ((char*)((ng3)));
    t5 = (t1 + 3912);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(80, ng0);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    xsi_process_wait(t5, 1000LL);
    *((char **)t3) = &&LAB9;
    t0 = 1;
    goto LAB1;

LAB9:    xsi_set_current_line(80, ng0);
    t6 = (t1 + 1912U);
    t7 = *((char **)t6);
    t6 = (t1 + 5352);
    xsi_vlogvar_assign_value(t6, t7, 0, 0, 32);
    xsi_set_current_line(81, ng0);
    t4 = xsi_vlog_time(t8, 1000.0000000000000, 1000.0000000000000);
    t5 = (t1 + 5192);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t1 + 5352);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t1 + 1280);
    xsi_vlogfile_write(1, 0, 0, ng5, 4, t12, (char)118, t8, 64, (char)118, t7, 16, (char)118, t11, 32);
    goto LAB4;

}

static void Initial_87_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;

LAB0:    t1 = (t0 + 6272U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(87, ng0);

LAB4:    xsi_set_current_line(89, ng0);
    t2 = (t0 + 4232);
    xsi_set_assignedflag(t2);
    t3 = (t0 + 9448);
    *((int *)t3) = 1;
    NetReassign_89_2(t0);
    xsi_set_current_line(90, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 2952);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(91, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3112);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(92, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3272);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 16);
    xsi_set_current_line(93, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3912);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3432);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(95, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3592);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(96, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 4552);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 3752);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(98, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 4072);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    xsi_set_current_line(99, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 4232);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(102, ng0);
    t2 = (t0 + 6080);
    xsi_process_wait(t2, 100000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(105, ng0);
    t2 = (t0 + 6080);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(106, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3112);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(107, ng0);
    t2 = (t0 + 6080);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB7;
    goto LAB1;

LAB7:    xsi_set_current_line(110, ng0);
    t2 = ((char*)((ng7)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB10:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB12:    if (t17 != 0)
        goto LAB13;

LAB8:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB9:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(111, ng0);
    t2 = ((char*)((ng8)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB16:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB18:    if (t17 != 0)
        goto LAB19;

LAB14:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB15:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(114, ng0);
    t2 = ((char*)((ng9)));
    t3 = ((char*)((ng3)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB22:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB24:    if (t17 != 0)
        goto LAB25;

LAB20:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB21:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(115, ng0);
    t2 = ((char*)((ng10)));
    t3 = ((char*)((ng11)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB28:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB30:    if (t17 != 0)
        goto LAB31;

LAB26:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB27:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(116, ng0);
    t2 = ((char*)((ng12)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB34:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB36:    if (t17 != 0)
        goto LAB37;

LAB32:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB33:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(117, ng0);
    t2 = ((char*)((ng3)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB40:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB42:    if (t17 != 0)
        goto LAB43;

LAB38:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB39:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(118, ng0);
    t2 = (t0 + 7184);
    *((int *)t2) = 1;
    t3 = (t0 + 6304);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB44;
    goto LAB1;

LAB11:;
LAB13:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB10;
    goto LAB1;

LAB17:;
LAB19:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB16;
    goto LAB1;

LAB23:;
LAB25:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB22;
    goto LAB1;

LAB29:;
LAB31:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB28;
    goto LAB1;

LAB35:;
LAB37:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB34;
    goto LAB1;

LAB41:;
LAB43:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB40;
    goto LAB1;

LAB44:    xsi_set_current_line(119, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 6080);
    t4 = (t0 + 1280);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t6 = (t0 + 5192);
    xsi_vlogvar_assign_value(t6, t2, 0, 0, 16);

LAB47:    t7 = (t0 + 6176);
    t8 = *((char **)t7);
    t9 = (t8 + 80U);
    t10 = *((char **)t9);
    t11 = (t10 + 272U);
    t12 = *((char **)t11);
    t13 = (t12 + 0U);
    t14 = *((char **)t13);
    t17 = ((int  (*)(char *, char *))t14)(t0, t8);

LAB49:    if (t17 != 0)
        goto LAB50;

LAB45:    t8 = (t0 + 1280);
    xsi_vlog_subprogram_popinvocation(t8);

LAB46:    t15 = (t0 + 6176);
    t16 = *((char **)t15);
    t15 = (t0 + 5352);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    t20 = (t0 + 4712);
    xsi_vlogvar_assign_value(t20, t19, 0, 0, 32);
    t21 = (t0 + 1280);
    t22 = (t0 + 6080);
    t23 = 0;
    xsi_delete_subprogram_invocation(t21, t16, t0, t22, t23);
    xsi_set_current_line(122, ng0);
    t2 = ((char*)((ng9)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB53:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB55:    if (t17 != 0)
        goto LAB56;

LAB51:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB52:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(123, ng0);
    t2 = ((char*)((ng10)));
    t3 = ((char*)((ng13)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB59:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB61:    if (t17 != 0)
        goto LAB62;

LAB57:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB58:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(124, ng0);
    t2 = ((char*)((ng3)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB65:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB67:    if (t17 != 0)
        goto LAB68;

LAB63:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB64:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(125, ng0);
    t2 = (t0 + 7200);
    *((int *)t2) = 1;
    t3 = (t0 + 6304);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB69;
    goto LAB1;

LAB48:;
LAB50:    t7 = (t0 + 6272U);
    *((char **)t7) = &&LAB47;
    goto LAB1;

LAB54:;
LAB56:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB53;
    goto LAB1;

LAB60:;
LAB62:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB59;
    goto LAB1;

LAB66:;
LAB68:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB65;
    goto LAB1;

LAB69:    xsi_set_current_line(126, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 6080);
    t4 = (t0 + 1280);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t6 = (t0 + 5192);
    xsi_vlogvar_assign_value(t6, t2, 0, 0, 16);

LAB72:    t7 = (t0 + 6176);
    t8 = *((char **)t7);
    t9 = (t8 + 80U);
    t10 = *((char **)t9);
    t11 = (t10 + 272U);
    t12 = *((char **)t11);
    t13 = (t12 + 0U);
    t14 = *((char **)t13);
    t17 = ((int  (*)(char *, char *))t14)(t0, t8);

LAB74:    if (t17 != 0)
        goto LAB75;

LAB70:    t8 = (t0 + 1280);
    xsi_vlog_subprogram_popinvocation(t8);

LAB71:    t15 = (t0 + 6176);
    t16 = *((char **)t15);
    t15 = (t0 + 5352);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    t20 = (t0 + 4712);
    xsi_vlogvar_assign_value(t20, t19, 0, 0, 32);
    t21 = (t0 + 1280);
    t22 = (t0 + 6080);
    t23 = 0;
    xsi_delete_subprogram_invocation(t21, t16, t0, t22, t23);
    xsi_set_current_line(129, ng0);
    t2 = ((char*)((ng9)));
    t3 = ((char*)((ng14)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB78:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB80:    if (t17 != 0)
        goto LAB81;

LAB76:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB77:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(130, ng0);
    t2 = ((char*)((ng10)));
    t3 = ((char*)((ng15)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB84:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB86:    if (t17 != 0)
        goto LAB87;

LAB82:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB83:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(131, ng0);
    t2 = ((char*)((ng3)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB90:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB92:    if (t17 != 0)
        goto LAB93;

LAB88:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB89:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(132, ng0);
    t2 = (t0 + 7216);
    *((int *)t2) = 1;
    t3 = (t0 + 6304);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB94;
    goto LAB1;

LAB73:;
LAB75:    t7 = (t0 + 6272U);
    *((char **)t7) = &&LAB72;
    goto LAB1;

LAB79:;
LAB81:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB78;
    goto LAB1;

LAB85:;
LAB87:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB84;
    goto LAB1;

LAB91:;
LAB93:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB90;
    goto LAB1;

LAB94:    xsi_set_current_line(133, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 6080);
    t4 = (t0 + 1280);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t6 = (t0 + 5192);
    xsi_vlogvar_assign_value(t6, t2, 0, 0, 16);

LAB97:    t7 = (t0 + 6176);
    t8 = *((char **)t7);
    t9 = (t8 + 80U);
    t10 = *((char **)t9);
    t11 = (t10 + 272U);
    t12 = *((char **)t11);
    t13 = (t12 + 0U);
    t14 = *((char **)t13);
    t17 = ((int  (*)(char *, char *))t14)(t0, t8);

LAB99:    if (t17 != 0)
        goto LAB100;

LAB95:    t8 = (t0 + 1280);
    xsi_vlog_subprogram_popinvocation(t8);

LAB96:    t15 = (t0 + 6176);
    t16 = *((char **)t15);
    t15 = (t0 + 5352);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    t20 = (t0 + 4712);
    xsi_vlogvar_assign_value(t20, t19, 0, 0, 32);
    t21 = (t0 + 1280);
    t22 = (t0 + 6080);
    t23 = 0;
    xsi_delete_subprogram_invocation(t21, t16, t0, t22, t23);
    xsi_set_current_line(136, ng0);
    t2 = ((char*)((ng9)));
    t3 = ((char*)((ng16)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB103:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB105:    if (t17 != 0)
        goto LAB106;

LAB101:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB102:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(137, ng0);
    t2 = ((char*)((ng10)));
    t3 = ((char*)((ng17)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB109:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB111:    if (t17 != 0)
        goto LAB112;

LAB107:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB108:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(138, ng0);
    t2 = ((char*)((ng3)));
    t3 = ((char*)((ng1)));
    t4 = (t0 + 6080);
    t5 = (t0 + 848);
    t6 = xsi_create_subprogram_invocation(t4, 0, t0, t5, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t5, t6);
    t7 = (t0 + 4872);
    xsi_vlogvar_assign_value(t7, t2, 0, 0, 16);
    t8 = (t0 + 5032);
    xsi_vlogvar_assign_value(t8, t3, 0, 0, 32);

LAB115:    t9 = (t0 + 6176);
    t10 = *((char **)t9);
    t11 = (t10 + 80U);
    t12 = *((char **)t11);
    t13 = (t12 + 272U);
    t14 = *((char **)t13);
    t15 = (t14 + 0U);
    t16 = *((char **)t15);
    t17 = ((int  (*)(char *, char *))t16)(t0, t10);

LAB117:    if (t17 != 0)
        goto LAB118;

LAB113:    t10 = (t0 + 848);
    xsi_vlog_subprogram_popinvocation(t10);

LAB114:    t18 = (t0 + 6176);
    t19 = *((char **)t18);
    t18 = (t0 + 848);
    t20 = (t0 + 6080);
    t21 = 0;
    xsi_delete_subprogram_invocation(t18, t19, t0, t20, t21);
    xsi_set_current_line(139, ng0);
    t2 = (t0 + 7232);
    *((int *)t2) = 1;
    t3 = (t0 + 6304);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB119;
    goto LAB1;

LAB98:;
LAB100:    t7 = (t0 + 6272U);
    *((char **)t7) = &&LAB97;
    goto LAB1;

LAB104:;
LAB106:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB103;
    goto LAB1;

LAB110:;
LAB112:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB109;
    goto LAB1;

LAB116:;
LAB118:    t9 = (t0 + 6272U);
    *((char **)t9) = &&LAB115;
    goto LAB1;

LAB119:    xsi_set_current_line(140, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 6080);
    t4 = (t0 + 1280);
    t5 = xsi_create_subprogram_invocation(t3, 0, t0, t4, 0, 0);
    xsi_vlog_subprogram_pushinvocation(t4, t5);
    t6 = (t0 + 5192);
    xsi_vlogvar_assign_value(t6, t2, 0, 0, 16);

LAB122:    t7 = (t0 + 6176);
    t8 = *((char **)t7);
    t9 = (t8 + 80U);
    t10 = *((char **)t9);
    t11 = (t10 + 272U);
    t12 = *((char **)t11);
    t13 = (t12 + 0U);
    t14 = *((char **)t13);
    t17 = ((int  (*)(char *, char *))t14)(t0, t8);

LAB124:    if (t17 != 0)
        goto LAB125;

LAB120:    t8 = (t0 + 1280);
    xsi_vlog_subprogram_popinvocation(t8);

LAB121:    t15 = (t0 + 6176);
    t16 = *((char **)t15);
    t15 = (t0 + 5352);
    t18 = (t15 + 56U);
    t19 = *((char **)t18);
    t20 = (t0 + 4712);
    xsi_vlogvar_assign_value(t20, t19, 0, 0, 32);
    t21 = (t0 + 1280);
    t22 = (t0 + 6080);
    t23 = 0;
    xsi_delete_subprogram_invocation(t21, t16, t0, t22, t23);
    goto LAB1;

LAB123:;
LAB125:    t7 = (t0 + 6272U);
    *((char **)t7) = &&LAB122;
    goto LAB1;

}

static void Always_146_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;

LAB0:    t1 = (t0 + 6520U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(147, ng0);

LAB4:    xsi_set_current_line(148, ng0);
    t2 = (t0 + 6328);
    xsi_process_wait(t2, 50000LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(149, ng0);
    t2 = (t0 + 2952);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    memset(t3, 0, 8);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t6);
    t8 = (~(t7));
    t9 = *((unsigned int *)t5);
    t10 = (t9 & t8);
    t11 = (t10 & 1U);
    if (t11 != 0)
        goto LAB9;

LAB7:    if (*((unsigned int *)t6) == 0)
        goto LAB6;

LAB8:    t12 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t12) = 1;

LAB9:    t13 = (t3 + 4);
    t14 = (t5 + 4);
    t15 = *((unsigned int *)t5);
    t16 = (~(t15));
    *((unsigned int *)t3) = t16;
    *((unsigned int *)t13) = 0;
    if (*((unsigned int *)t14) != 0)
        goto LAB11;

LAB10:    t21 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t21 & 1U);
    t22 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t22 & 1U);
    t23 = (t0 + 2952);
    xsi_vlogvar_wait_assign_value(t23, t3, 0, 0, 1, 0LL);
    goto LAB2;

LAB6:    *((unsigned int *)t3) = 1;
    goto LAB9;

LAB11:    t17 = *((unsigned int *)t3);
    t18 = *((unsigned int *)t14);
    *((unsigned int *)t3) = (t17 | t18);
    t19 = *((unsigned int *)t13);
    t20 = *((unsigned int *)t14);
    *((unsigned int *)t13) = (t19 | t20);
    goto LAB10;

}

static void NetReassign_89_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned int t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t1 = (t0 + 6768U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(89, ng0);
    t3 = 0;
    t2 = (t0 + 2072U);
    t4 = *((char **)t2);
    t2 = (t0 + 9448);
    if (*((int *)t2) > 0)
        goto LAB4;

LAB5:    if (t3 > 0)
        goto LAB6;

LAB7:    t7 = (t0 + 7248);
    *((int *)t7) = 0;

LAB8:
LAB1:    return;
LAB4:    t5 = (t0 + 4232);
    xsi_vlogvar_assignassignvalue(t5, t4, 0, 0, 0, 1, ((int*)(t2)));
    t3 = 1;
    goto LAB5;

LAB6:    t6 = (t0 + 7248);
    *((int *)t6) = 1;
    goto LAB8;

}


extern void work_m_00000000002436498228_0895204038_init()
{
	static char *pe[] = {(void *)Initial_87_0,(void *)Always_146_1,(void *)NetReassign_89_2};
	static char *se[] = {(void *)sp_apb_write32,(void *)sp_apb_read32};
	xsi_register_didat("work_m_00000000002436498228_0895204038", "isim/spi_top_test_isim_beh.exe.sim/work/m_00000000002436498228_0895204038.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
