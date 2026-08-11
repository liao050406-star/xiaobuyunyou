// =====================
// 页面切换基础功能
// =====================


function showPage(id){


    let pages=document.querySelectorAll(".page");


    pages.forEach(function(page){

        page.classList.remove("active");

    });



    let target=document.getElementById(id);


    if(target){

        target.classList.add("active");

    }


}






// =====================
// 开始游戏
// =====================


function startGame(){


    showPage("page-intro");


}






// =====================
// 第一幕：水坑望龙
// =====================


function firstScene(){


    showPage("page-water");


}






function waterChoice(answer){



    if(answer==="correct"){



        showPage("page-stone");



    }

    else{



        showWrongWater();



    }


}






function waterChoice(answer){

    if(answer==="correct"){

        showPage("page-stone");

    }else{

        showPage("page-water-wrong");

    }
}
// =====================
// 三个结局证章页面
// =====================

function showGrowthBadge(){

    showPage("page-badge-growth");

}


function showProtectBadge(){

    showPage("page-badge-protect");

}


function showBalanceBadge(){

    showPage("page-badge-balance");

}




// =====================
// 第二幕：废弃庭院
// =====================


function secondScene(){


    showPage("page-courtyard");


}






function bellChoice(answer){


    if(answer==="correct"){


        showPage("page-bell-success");


    }

    else{


        showPage("page-bell-wrong");


    }


}







// =====================
// 第三幕：灵羊问心
// =====================



function thirdScene(){


    showPage("page-choice");


}







function ending(type){



    if(type==="growth"){



        showPage("page-ending-growth");



    }



    if(type==="protect"){



        showPage("page-ending-protect");



    }



    if(type==="balance"){



        showPage("page-ending-balance");



    }



}








// =====================
// 商业转化页面
// =====================



function showProduct(){


    showPage("page-product");


}







// =====================
// 重新开始
// =====================



function restartGame(){


    showPage("page-cover");


}