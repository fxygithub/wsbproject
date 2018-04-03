function lookItem(code){
    var banshiGuide;
    if(code=="46020000SY-XK-0703"){//1首次发放
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000SY-XK-2520";
    }
    if(code=="46020000YG-FW-0101"){//2停业
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0109";
    }
    if(code=="46020000YG-FW-0102"){//3歇业
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0107";
    }
    if(code=="46020000YG-FW-0103"){//4补办
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0108";
    }
    if(code=="46020000YG-FW-0104"){//5恢复营业
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0110";
    }
    if(code=="46020000YG-XK-0101"){//6新办
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0102";
    }
    if(code=="46020000YG-XK-0102"){//7延续
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0104";
    }
    if(code=="46020000YG-XK-0103"){//8变更
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000YG-XK-0106";
    }
    if(code=="46020000ZF-XK-0402"){//9广告
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000ZF-XK-0201";
    }
    if(code=="46020000ZF-XK-0501"){//10道路
        banshiGuide="http://zwzx.sanya.gov.cn/zhengwu/sy_bszn.jsp?codenum=46020000ZF-XK-0102";
    }
    return banshiGuide;
}
