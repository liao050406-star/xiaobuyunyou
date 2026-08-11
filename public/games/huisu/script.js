let retryTarget = "page-level1";

let guardianOrder = [];



function showPage(id) {

    const pages = document.querySelectorAll(".page");

    pages.forEach(function(page) {
        page.classList.remove("active");
    });

    const target = document.getElementById(id);

    if (target) {
        target.classList.add("active");
    }

    window.scrollTo(0, 0);
}



function startGame() {

    showPage("page-intro");

}



function levelOne() {

    showPage("page-level1");

}



function chooseLevel1(answer) {

    if (answer === "bat") {

        showPage("page-level1-success");

    } else {

        showWrong(
            "page-level1",
            "这只瑞兽的寓意并不是“福气”。在岭南传统文化中，“蝠”与“福”同音，试着寻找蝙蝠纹样。"
        );

    }

}



function levelTwo() {

    showPage("page-level2");

}



function chooseLevel2(answer) {

    if (answer === "bat") {

        showPage("page-level2-success");

    } else {

        showWrong(
            "page-level2",
            "这块碎片与第一关获得的“福纹线索”并不能完全吻合。再观察一下蝙蝠纹样的轮廓。"
        );

    }

}



function levelThree() {

    guardianOrder = [];

    updateOrderText();

    showPage("page-level3");

}



function guardianChoose(beast) {

    if (guardianOrder.length >= 3) {
        return;
    }

    guardianOrder.push(beast);

    updateOrderText();


    if (guardianOrder.length === 3) {

        const correctOrder =
            guardianOrder[0] === "bat" &&
            guardianOrder[1] === "qilin" &&
            guardianOrder[2] === "crane";


        if (correctOrder) {

            setTimeout(function() {

                showPage("page-gate-success");

            }, 400);

        } else {

            setTimeout(function() {

                guardianOrder = [];

                updateOrderText();

                showWrong(
                    "page-level3",
                    "瑞兽的排列顺序还不正确。提示：“福至祥来，寿满人间”分别对应福气、祥瑞与长寿。"
                );

            }, 400);

        }

    }

}



function updateOrderText() {

    const text = document.getElementById("order-text");

    if (!text) {
        return;
    }


    if (guardianOrder.length === 0) {

        text.innerText = "当前选择：尚未选择";

        return;

    }


    const names = {

        bat: "蝙蝠",
        qilin: "麒麟",
        crane: "仙鹤"

    };


    const display = guardianOrder.map(function(item) {

        return names[item];

    });


    text.innerText =
        "当前选择：" + display.join(" → ");

}



function resetGuardianOrder() {

    guardianOrder = [];

    updateOrderText();

}



function showWrong(target, message) {

    retryTarget = target;

    const messageBox =
        document.getElementById("wrong-message");

    if (messageBox) {

        messageBox.innerText = message;

    }

    showPage("page-wrong");

}



function retryQuestion() {

    showPage(retryTarget);

}



function showFinal() {

    showPage("page-final");

}



function showConvert() {

    showPage("page-convert");

}



function restartGame() {

    guardianOrder = [];

    showPage("page-cover");

}