"use client";

import { FormEvent, useState } from "react";
import "./museum.css";

type Section = "home" | "museum" | "map" | "games" | "shop" | "experience";

const nav: { id: Section; label: string }[] = [
  { id: "home", label: "认识小㘵" },
  { id: "museum", label: "小㘵文化馆" },
  { id: "map", label: "云游地图" },
  { id: "games", label: "玩转小㘵" },
  { id: "shop", label: "小㘵文创" },
  { id: "experience", label: "来小㘵玩" },
];

const stories = [
  { icon: "榕", title: "古榕树", tag: "村落记忆", text: "年轮记录着小㘵村的日常，也为来访者留下最安静的停留处。", image: "/museum-assets/ancient-banyan.png", detail: "盘根与垂须把一处村中空地围成天然会客厅。它既是遮阴的树，也是村民日常相遇、讲述往事的记忆坐标。", clue: "寻找石板路与树根交会的位置，完成“村落记忆”打卡。" },
  { icon: "祠", title: "古祠堂", tag: "建筑文脉", text: "青砖、屋脊与门楣之间，保存着村落敬祖睦族的共同记忆。", image: "/museum-assets/ancestral-hall.png", detail: "门楼、砖墙与檐口共同构成岭南传统建筑的秩序。进入祠堂，不只是在看一座建筑，也是在阅读村落的家族记忆。", clue: "观察门楣、屋脊和青砖的层次，找到建筑文脉线索。" },
  { icon: "塑", title: "岭南灰塑", tag: "非遗技艺", text: "蝙蝠、麒麟、仙鹤等纹样，把福、祥、寿写在岭南屋脊之上。", image: "/museum-assets/gray-plastic-roof.png", detail: "灰塑将石灰、纸筋等材料塑成飞禽瑞兽与花卉故事。屋脊上的蝙蝠、麒麟、仙鹤，分别寄托福气、祥瑞与长寿。", clue: "点击后可前往《灰塑寻踪》，继续辨认三种瑞兽纹样。" },
  { icon: "山", title: "羚羊山", tag: "山海传说", text: "山路通往远望，也通往灵羊守护山村的故事。", image: "/museum-assets/lingyang-mountain.png", detail: "山路把古村、林地与远望串联起来。灵羊传说并非遥远的神话，而是一种关于山村共生、生态守护的想象。", clue: "沿徒步线抵达登山入口，解锁“灵羊守护者”任务。" },
];

const products = [
  { kind: "盒装故事", title: "《五姓遗卷》", text: "60—90分钟古村文旅解谜盒，循线寻找遗失的村落记忆。", cta: "了解剧本" },
  { kind: "游戏身份", title: "守护者徽章", text: "灵羊、灰塑、逐潮与守旧四种身份，线上通关、线下兑换。", cta: "查看徽章" },
  { kind: "旅行打卡", title: "小㘵探索护照", text: "把文化点位、游戏任务和到村印章收进一本旅行手册。", cta: "查看护照" },
  { kind: "灰塑瑞兽", title: "福·祥·寿周边", text: "蝙蝠、麒麟、仙鹤三件套，带走屋脊上的岭南祝福。", cta: "查看周边" },
];

const experiences = [
  { time: "2—3小时", title: "寻迹小㘵·古村半日游", text: "古建导览、灰塑点位打卡与农家体验。", tag: "亲子 / 普通游客" },
  { time: "2—3小时", title: "灰塑守护者体验营", text: "纹样讲解、简化版DIY、游戏任务与徽章兑换。", tag: "亲子 / 研学团" },
  { time: "半天", title: "灵羊守护者徒步线", text: "羚羊山故事任务、生态提示与古村服务站休整。", tag: "青年 / 团建" },
  { time: "半天—一天", title: "五姓寻脉研学活动", text: "剧本解谜、古村实地任务与文化成果展示。", tag: "学生 / 团队" },
];

export default function Home() {
  const [section, setSection] = useState<Section>("home");
  const [activeSpot, setActiveSpot] = useState("");
  const [submitted, setSubmitted] = useState(false);
  const [activeMuseum, setActiveMuseum] = useState(0);

  const go = (id: Section) => { setSection(id); setSubmitted(false); window.scrollTo({ top: 0, behavior: "smooth" }); };
  const openBooking = (event: FormEvent<HTMLFormElement>) => { event.preventDefault(); setSubmitted(true); };

  return (
    <main>
      <header className="topbar">
        <button className="brand" onClick={() => go("home")} aria-label="返回首页"><span>小㘵</span>云游</button>
        <nav aria-label="主导航">{nav.map((item) => <button key={item.id} className={section === item.id ? "active" : ""} onClick={() => go(item.id)}>{item.label}</button>)}</nav>
      </header>

      {section === "home" && <section className="home">
        <div className="hero-copy">
          <p className="eyebrow">600年古村 · 岭南灰塑 · 羚羊山</p>
          <h1>古村有形<br/><em>文化有魂</em></h1>
          <p className="lead">从一块灰塑、一段村道，读懂一座古村。<br/>在小㘵，开始一场关于山、村与守护的探索。</p>
          <div className="actions"><button className="primary" onClick={() => go("museum")}>进入文化馆</button><button className="ghost" onClick={() => go("games")}>玩互动故事</button></div>
        </div>
        <div className="hero-art" aria-label="小㘵村意象插画"><div className="sun"/><div className="mountain m1"/><div className="mountain m2"/><div className="village"/><div className="tree"/><div className="tree-crown"/><p>小㘵文化馆</p></div>
        <div className="start-grid">
          {nav.slice(1).map((item, index) => <button key={item.id} className="start-card" onClick={() => go(item.id)}><b>0{index + 1}</b><span>{item.label}</span><small>点击探索 →</small></button>)}
        </div>
      </section>}

      {section === "museum" && <section className="page museum">
        <p className="eyebrow">小㘵文化馆</p><h2>把散落在村里的故事，<br/>收藏进一次可抵达的相遇。</h2>
        <p className="intro">古建筑、岭南灰塑、村落记忆与羚羊山传说，构成小㘵文化馆的四个展厅。线下扫描建筑二维码，也能回到这里继续听故事。</p>
        <div className="museum-guide"><div><b>01</b><span>看一棵树</span><small>从古榕的根系，读村落的日常记忆。</small></div><div><b>02</b><span>望一座山</span><small>沿羚羊山的传说，理解守护与共生。</small></div><div><b>03</b><span>认一片灰塑</span><small>在屋脊瑞兽中寻找福、祥、寿的寓意。</small></div><div><b>04</b><span>进一座祠堂</span><small>从砖瓦门楣，触摸岭南建筑文脉。</small></div></div>
        <div className="museum-gallery" aria-label="四个文化展厅入口">{stories.map((story, index) => <button key={story.title} className={activeMuseum === index ? "selected" : ""} onClick={() => setActiveMuseum(index)}><img src={story.image} alt={`${story.title}展厅入口`}/><span>{story.tag}</span><b>{story.title}</b><small>点击听故事</small></button>)}</div>
        <section className="story-stage"><div className="stage-art"><img src={stories[activeMuseum].image} alt={stories[activeMuseum].title}/><span>{stories[activeMuseum].icon}</span></div><div className="stage-copy"><p>{stories[activeMuseum].tag}</p><h3>{stories[activeMuseum].title}</h3><strong>展板故事</strong><div className="stage-text"><p>{stories[activeMuseum].detail}</p><p>{stories[activeMuseum].clue}</p></div><div className="stage-actions"><button className="primary" onClick={() => { setActiveSpot(stories[activeMuseum].title); go("map"); }}>在地图中寻迹 →</button>{activeMuseum === 2 ? <button className="outline" onClick={() => go("games")}>进入灰塑寻踪</button> : <button className="outline" onClick={() => go(activeMuseum === 3 ? "experience" : "map")}>{activeMuseum === 3 ? "查看徒步体验" : "继续云游"}</button>}</div></div></section>
        <div className="story-grid">{stories.map((story, index) => <article className="story-card" key={story.title}><div className="round-icon">{story.icon}</div><p>{story.tag}</p><h3>{story.title}</h3><span>{story.text}</span><button onClick={() => setActiveMuseum(index)}>阅读展板故事 →</button></article>)}</div>
        <div className="museum-footer"><div><b>线下扫码，线上续游</b><span>到达古榕、祠堂、灰塑点位后，可用二维码解锁图文故事与互动任务。</span></div><button className="primary" onClick={() => go("map")}>打开云游地图 →</button></div>
      </section>}

      {section === "map" && <section className="page map-page">
        <p className="eyebrow">云游小㘵</p><h2>沿着文化点位，<br/>走进真实的村庄。</h2>
        <div className="map-layout"><div className="map-board" aria-label="小㘵村文化导览示意图"><div className="map-mountain">羚羊山</div><div className="route-line"/><div className="route-label">灵羊守护者徒步线</div>{[
          ["古榕树", "spot-1"], ["古祠堂", "spot-2"], ["灰塑老屋", "spot-3"], ["古村道", "spot-4"], ["服务站", "spot-5"], ["登山入口", "spot-6"],
        ].map(([name, cls]) => <button key={name} className={`map-spot ${cls} ${activeSpot === name ? "selected" : ""}`} onClick={() => setActiveSpot(name)}><i>●</i>{name}</button>)}</div>
          <aside className="spot-panel"><p className="eyebrow">{activeSpot || "点击地图点位"}</p><h3>{activeSpot || "小㘵文化导览"}</h3><p>{activeSpot ? `${activeSpot}承载着小㘵村独有的生活记忆与文化线索。到村后可扫描点位二维码，查看图文故事与相关任务。` : "从古村文化点位出发，查看灰塑、建筑、村史和徒步路线。"}</p><div className="panel-actions"><button className="primary" onClick={() => go(activeSpot === "登山入口" ? "experience" : "museum")}>{activeSpot === "登山入口" ? "查看徒步体验" : "阅读文化故事"}</button><button className="outline" onClick={() => go("games")}>领取互动任务</button></div><small>注：本地图为文化导览示意，徒步请遵循现场管理与安全提示。</small></aside>
        </div>
      </section>}

      {section === "games" && <section className="page games"><p className="eyebrow">玩转小㘵</p><h2>不是旁观故事，<br/>而是成为故事的一部分。</h2><p className="intro">两款已完成的互动网页游戏，以轻量解谜和剧情选择，让灰塑、羚羊山和古村守护变得可玩、可记、可分享。</p><div className="game-grid"><article className="game-card huisu"><img src="/games/huisu/01_cover.webp" alt="灰塑寻踪游戏封面"/><div><p>灰塑文化闯关</p><h3>《灰塑寻踪》</h3><span>认识瑞兽、修复纹样、破解祠堂文化密码。</span><a href="/games/huisu/index.html" target="_blank" rel="noreferrer">开始寻找 →</a></div></article><article className="game-card lingyang"><img src="/games/lingyang/01_cover.webp" alt="灵羊镇海游戏封面"/><div><p>羚羊山互动剧情</p><h3>《灵羊镇海》</h3><span>循着山纹石片与守山铜铃，作出关于古村未来的选择。</span><a href="/games/lingyang/index.html" target="_blank" rel="noreferrer">开启传说 →</a></div></article></div></section>}

      {section === "shop" && <section className="page shop"><p className="eyebrow">小㘵文创</p><h2>把一段古村故事，<br/>带回日常生活。</h2><p className="intro">每件文创都源自游戏身份、灰塑纹样或古村线索。首期以展示和预购登记为主，暂不接入在线支付。</p><div className="product-grid">{products.map((product, index) => <article className="product-card" key={product.title}><div className={`product-object obj-${index}`}><span>{index === 0 ? "五姓\n遗卷" : index === 1 ? "守护\n徽章" : index === 2 ? "探索\n护照" : "福 祥 寿"}</span></div><p>{product.kind}</p><h3>{product.title}</h3><span>{product.text}</span><button onClick={() => go("experience")}>{product.cta} →</button></article>)}</div></section>}

      {section === "experience" && <section className="page experience"><p className="eyebrow">来小㘵玩</p><h2>从线上故事出发，<br/>到村里完成一次真实探索。</h2><div className="experience-layout"><div className="experience-list">{experiences.map((item) => <article key={item.title}><b>{item.time}</b><div><p>{item.tag}</p><h3>{item.title}</h3><span>{item.text}</span></div><button onClick={() => document.getElementById("booking")?.scrollIntoView({ behavior: "smooth" })}>预约 →</button></article>)}</div><form id="booking" className="booking" onSubmit={openBooking}>{submitted ? <div className="success"><p>预约信息已记录</p><h3>我们会尽快为你匹配体验方案</h3><button type="button" className="primary" onClick={() => setSubmitted(false)}>再次填写</button></div> : <><p className="eyebrow">体验预约</p><h3>计划一次小㘵之行</h3><label>姓名<input required placeholder="怎么称呼你"/></label><label>联系方式<input required placeholder="手机号或微信"/></label><label>想体验什么<select defaultValue=""><option value="" disabled>请选择体验项目</option>{experiences.map((item) => <option key={item.title}>{item.title}</option>)}</select></label><label>人数<select defaultValue=""><option value="" disabled>请选择人数</option><option>1—5人</option><option>6—15人</option><option>16人以上</option></select></label><button className="primary" type="submit">提交预约意向</button><small>提交后由项目方及合作服务方与您联系确认；本页暂不收款。</small></>}</form></div></section>}

      <footer><span>小㘵云游 · 古村有形，文化有魂</span><button onClick={() => go("home")}>回到首页 ↑</button></footer>
    </main>
  );
}
