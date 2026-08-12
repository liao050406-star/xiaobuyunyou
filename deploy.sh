#!/bin/bash
# Deploy static site to GitHub Pages
# Usage: bash deploy.sh

set -e
cd "$(dirname "$0")"

echo "=== Step 1: Build ==="
export WRANGLER_LOG_PATH=".wrangler/wrangler.log"
npx vinext build

echo "=== Step 2: Copy & Fix CSS ==="
cd dist/client
INDEX_CSS=$(ls index.*.css 2>/dev/null | head -1)
PAGE_CSS=$(ls page.*.css 2>/dev/null | head -1)
cp "_next/static/css/$INDEX_CSS" . 2>/dev/null
cp "_next/static/css/$PAGE_CSS" . 2>/dev/null

# Fix absolute paths in CSS for GitHub Pages (project site)
for f in *.css _next/static/css/*.css; do
  [ -f "$f" ] && sed -i 's|url(/|url(|g' "$f"
done

echo "=== Step 3: Generate index.html ==="
cat > index.html << 'INDEXEOF'
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>小㘵云游｜古村有形，文化有魂</title>
<meta name="description" content="小㘵村文化展厅、云游地图、互动游戏、文创与线下体验预约。">
<base href="/xiaobuyunyou/">
<link rel="icon" type="image/svg+xml" href="favicon.svg">
<link rel="stylesheet" href="INDEX_CSS_PLACEHOLDER">
<link rel="stylesheet" href="PAGE_CSS_PLACEHOLDER">
</head>
<body>
<main>
  <header class="topbar">
    <button class="brand" data-nav="home" aria-label="返回首页"><span>小㘵</span>云游</button>
    <nav aria-label="主导航">
      <button class="active" data-nav="home">认识小㘵</button>
      <button data-nav="museum">小㘵文化馆</button>
      <button data-nav="map">云游地图</button>
      <button data-nav="games">玩转小㘵</button>
      <button data-nav="shop">小㘵文创</button>
      <button data-nav="experience">来小㘵玩</button>
    </nav>
  </header>

  <section class="home" data-section="home">
    <div class="hero-copy">
      <p class="eyebrow">600年古村 · 岭南灰塑 · 羚羊山</p>
      <h1>古村有形<br><em>文化有魂</em></h1>
      <p class="lead">从一块灰塑、一段村道，读懂一座古村。<br>在小㘵，开始一场关于山、村与守护的探索。</p>
      <div class="actions"><button class="primary" data-nav="museum">进入文化馆</button><button class="ghost" data-nav="games">玩互动故事</button></div>
    </div>
    <div class="hero-art" aria-label="小㘵村意象插画">
      <div class="sun"></div><div class="mountain m1"></div><div class="mountain m2"></div><div class="village"></div><div class="tree"></div><div class="tree-crown"></div><p>小㘵文化馆</p>
    </div>
    <div class="start-grid">
      <button class="start-card" data-nav="museum"><b>01</b><span>小㘵文化馆</span><small>点击探索 →</small></button>
      <button class="start-card" data-nav="map"><b>02</b><span>云游地图</span><small>点击探索 →</small></button>
      <button class="start-card" data-nav="games"><b>03</b><span>玩转小㘵</span><small>点击探索 →</small></button>
      <button class="start-card" data-nav="shop"><b>04</b><span>小㘵文创</span><small>点击探索 →</small></button>
      <button class="start-card" data-nav="experience"><b>05</b><span>来小㘵玩</span><small>点击探索 →</small></button>
    </div>
  </section>

  <section class="page museum" data-section="museum" hidden>
    <p class="eyebrow">小㘵文化馆</p>
    <h2>把散落在村里的故事，<br>收藏进一次可抵达的相遇。</h2>
    <p class="intro">古建筑、岭南灰塑、村落记忆与羚羊山传说，构成小㘵文化馆的四个展厅。线下扫描建筑二维码，也能回到这里继续听故事。</p>

    <div class="museum-guide">
      <div><b>01</b><span>看一棵树</span><small>从古榕的根系，读村落的日常记忆。</small></div>
      <div><b>02</b><span>望一座山</span><small>沿羚羊山的传说，理解守护与共生。</small></div>
      <div><b>03</b><span>认一片灰塑</span><small>在屋脊瑞兽中寻找福、祥、寿的寓意。</small></div>
      <div><b>04</b><span>进一座祠堂</span><small>从砖瓦门楣，触摸岭南建筑文脉。</small></div>
    </div>

    <div class="museum-gallery" aria-label="四个文化展厅入口">
      <button class="selected" data-museum="0"><img src="museum-assets/ancient-banyan.png" alt="古榕树展厅入口"><span>村落记忆</span><b>古榕树</b><small>点击听故事</small></button>
      <button data-museum="1"><img src="museum-assets/ancestral-hall.png" alt="古祠堂展厅入口"><span>建筑文脉</span><b>古祠堂</b><small>点击听故事</small></button>
      <button data-museum="2"><img src="museum-assets/gray-plastic-roof.png" alt="岭南灰塑展厅入口"><span>非遗技艺</span><b>岭南灰塑</b><small>点击听故事</small></button>
      <button data-museum="3"><img src="museum-assets/lingyang-mountain.png" alt="羚羊山展厅入口"><span>山海传说</span><b>羚羊山</b><small>点击听故事</small></button>
    </div>

    <section class="story-stage">
      <div class="stage-art"><img src="museum-assets/ancient-banyan.png" alt="古榕树" id="stageImg"><span id="stageIcon">榕</span></div>
      <div class="stage-copy">
        <p id="stageTag">村落记忆</p>
        <h3 id="stageTitle">古榕树</h3>
        <strong>展板故事</strong>
        <div class="stage-text"><p id="stageDetail">盘根与垂须把一处村中空地围成天然会客厅。它既是遮阴的树，也是村民日常相遇、讲述往事的记忆坐标。</p><p id="stageClue">寻找石板路与树根交会的位置，完成"村落记忆"打卡。</p></div>
        <div class="stage-actions">
          <button class="primary" id="stagePrimary" data-nav="map" data-spot="古榕树">在地图中寻迹 →</button>
          <button class="outline" id="stageSecondary" data-nav="map">继续云游</button>
        </div>
      </div>
    </section>

    <div class="story-grid">
      <article class="story-card"><div class="round-icon">榕</div><p>村落记忆</p><h3>古榕树</h3><span>年轮记录着小㘵村的日常，也为来访者留下最安静的停留处。</span><button data-museum-nav="0">阅读展板故事 →</button></article>
      <article class="story-card"><div class="round-icon">祠</div><p>建筑文脉</p><h3>古祠堂</h3><span>青砖、屋脊与门楣之间，保存着村落敬祖睦族的共同记忆。</span><button data-museum-nav="1">阅读展板故事 →</button></article>
      <article class="story-card"><div class="round-icon">塑</div><p>非遗技艺</p><h3>岭南灰塑</h3><span>蝙蝠、麒麟、仙鹤等纹样，把福、祥、寿写在岭南屋脊之上。</span><button data-museum-nav="2">阅读展板故事 →</button></article>
      <article class="story-card"><div class="round-icon">山</div><p>山海传说</p><h3>羚羊山</h3><span>山路通往远望，也通往灵羊守护山村的故事。</span><button data-museum-nav="3">阅读展板故事 →</button></article>
    </div>

    <div class="museum-footer">
      <div><b>线下扫码，线上续游</b><span>到达古榕、祠堂、灰塑点位后，可用二维码解锁图文故事与互动任务。</span></div>
      <button class="primary" data-nav="map">打开云游地图 →</button>
    </div>
  </section>

  <section class="page map-page" data-section="map" hidden>
    <p class="eyebrow">云游小㘵</p>
    <h2>沿着文化点位，<br>走进真实的村庄。</h2>
    <div class="map-layout">
      <div class="map-board" aria-label="小㘵村文化导览示意图">
        <div class="map-mountain">羚羊山</div>
        <div class="route-line"></div>
        <div class="route-label">灵羊守护者徒步线</div>
        <button class="map-spot spot-1" data-spot="古榕树"><i>●</i>古榕树</button>
        <button class="map-spot spot-2" data-spot="古祠堂"><i>●</i>古祠堂</button>
        <button class="map-spot spot-3" data-spot="灰塑老屋"><i>●</i>灰塑老屋</button>
        <button class="map-spot spot-4" data-spot="古村道"><i>●</i>古村道</button>
        <button class="map-spot spot-5" data-spot="服务站"><i>●</i>服务站</button>
        <button class="map-spot spot-6" data-spot="登山入口"><i>●</i>登山入口</button>
      </div>
      <aside class="spot-panel">
        <p class="eyebrow" id="spotEyebrow">点击地图点位</p>
        <h3 id="spotTitle">小㘵文化导览</h3>
        <p id="spotDesc">从古村文化点位出发，查看灰塑、建筑、村史和徒步路线。</p>
        <div class="panel-actions">
          <button class="primary" id="spotPrimary" data-nav="museum">阅读文化故事</button>
          <button class="outline" data-nav="games">领取互动任务</button>
        </div>
        <small>注：本地图为文化导览示意，徒步请遵循现场管理与安全提示。</small>
      </aside>
    </div>
  </section>

  <section class="page games" data-section="games" hidden>
    <p class="eyebrow">玩转小㘵</p>
    <h2>不是旁观故事，<br>而是成为故事的一部分。</h2>
    <p class="intro">两款已完成的互动网页游戏，以轻量解谜和剧情选择，让灰塑、羚羊山和古村守护变得可玩、可记、可分享。</p>
    <div class="game-grid">
      <article class="game-card huisu">
        <img src="games/huisu/01_cover.webp" alt="灰塑寻踪游戏封面">
        <div><p>灰塑文化闯关</p><h3>《灰塑寻踪》</h3><span>认识瑞兽、修复纹样、破解祠堂文化密码。</span><a href="games/huisu/index.html" target="_blank" rel="noreferrer">开始寻找 →</a></div>
      </article>
      <article class="game-card lingyang">
        <img src="games/lingyang/01_cover.webp" alt="灵羊镇海游戏封面">
        <div><p>羚羊山互动剧情</p><h3>《灵羊镇海》</h3><span>循着山纹石片与守山铜铃，作出关于古村未来的选择。</span><a href="games/lingyang/index.html" target="_blank" rel="noreferrer">开启传说 →</a></div>
      </article>
    </div>
  </section>

  <section class="page shop" data-section="shop" hidden>
    <p class="eyebrow">小㘵文创</p>
    <h2>把一段古村故事，<br>带回日常生活。</h2>
    <p class="intro">每件文创都源自游戏身份、灰塑纹样或古村线索。首期以展示和预购登记为主，暂不接入在线支付。</p>
    <div class="product-grid">
      <article class="product-card"><div class="product-object obj-0"><span>五姓
遗卷</span></div><p>盒装故事</p><h3>《五姓遗卷》</h3><span>60—90分钟古村文旅解谜盒，循线寻找遗失的村落记忆。</span><button data-nav="experience">了解剧本 →</button></article>
      <article class="product-card"><div class="product-object obj-1"><span>守护
徽章</span></div><p>游戏身份</p><h3>守护者徽章</h3><span>灵羊、灰塑、逐潮与守旧四种身份，线上通关、线下兑换。</span><button data-nav="experience">查看徽章 →</button></article>
      <article class="product-card"><div class="product-object obj-2"><span>探索
护照</span></div><p>旅行打卡</p><h3>小㘵探索护照</h3><span>把文化点位、游戏任务和到村印章收进一本旅行手册。</span><button data-nav="experience">查看护照 →</button></article>
      <article class="product-card"><div class="product-object obj-3"><span>福 祥 寿</span></div><p>灰塑瑞兽</p><h3>福·祥·寿周边</h3><span>蝙蝠、麒麟、仙鹤三件套，带走屋脊上的岭南祝福。</span><button data-nav="experience">查看周边 →</button></article>
    </div>
  </section>

  <section class="page experience" data-section="experience" hidden>
    <p class="eyebrow">来小㘵玩</p>
    <h2>从线上故事出发，<br>到村里完成一次真实探索。</h2>
    <div class="experience-layout">
      <div class="experience-list">
        <article><b>2—3小时</b><div><p>亲子 / 普通游客</p><h3>寻迹小㘵·古村半日游</h3><span>古建导览、灰塑点位打卡与农家体验。</span></div><button data-scroll="booking">预约 →</button></article>
        <article><b>2—3小时</b><div><p>亲子 / 研学团</p><h3>灰塑守护者体验营</h3><span>纹样讲解、简化版DIY、游戏任务与徽章兑换。</span></div><button data-scroll="booking">预约 →</button></article>
        <article><b>半天</b><div><p>青年 / 团建</p><h3>灵羊守护者徒步线</h3><span>羚羊山故事任务、生态提示与古村服务站休整。</span></div><button data-scroll="booking">预约 →</button></article>
        <article><b>半天—一天</b><div><p>学生 / 团队</p><h3>五姓寻脉研学活动</h3><span>剧本解谜、古村实地任务与文化成果展示。</span></div><button data-scroll="booking">预约 →</button></article>
      </div>
      <form id="booking" class="booking">
        <div class="booking-form">
          <p class="eyebrow">体验预约</p>
          <h3>计划一次小㘵之行</h3>
          <label>姓名<input required placeholder="怎么称呼你"></label>
          <label>联系方式<input required placeholder="手机号或微信"></label>
          <label>想体验什么<select><option value="" disabled selected>请选择体验项目</option><option>寻迹小㘵·古村半日游</option><option>灰塑守护者体验营</option><option>灵羊守护者徒步线</option><option>五姓寻脉研学活动</option></select></label>
          <label>人数<select><option value="" disabled selected>请选择人数</option><option>1—5人</option><option>6—15人</option><option>16人以上</option></select></label>
          <button class="primary" type="submit">提交预约意向</button>
          <small>提交后由项目方及合作服务方与您联系确认；本页暂不收款。</small>
        </div>
        <div class="success" hidden>
          <p>预约信息已记录</p>
          <h3>我们会尽快为你匹配体验方案</h3>
          <button type="button" class="primary" data-reset-form>再次填写</button>
        </div>
      </form>
    </div>
  </section>

  <footer>
    <span>小㘵云游 · 古村有形，文化有魂</span>
    <button data-nav="home">回到首页 ↑</button>
  </footer>
</main>

<script>
// ── Museum gallery & story-stage data ──
var museumData = [
  {icon:"榕",tag:"村落记忆",title:"古榕树",image:"museum-assets/ancient-banyan.png",detail:"盘根与垂须把一处村中空地围成天然会客厅。它既是遮阴的树，也是村民日常相遇、讲述往事的记忆坐标。",clue:"寻找石板路与树根交会的位置，完成“村落记忆”打卡。",spot:"古榕树",secondaryNav:"map",secondaryLabel:"继续云游"},
  {icon:"祠",tag:"建筑文脉",title:"古祠堂",image:"museum-assets/ancestral-hall.png",detail:"门楼、砖墙与檐口共同构成岭南传统建筑的秩序。进入祠堂，不只是在看一座建筑，也是在阅读村落的家族记忆。",clue:"观察门楣、屋脊和青砖的层次，找到建筑文脉线索。",spot:"古祠堂",secondaryNav:"map",secondaryLabel:"继续云游"},
  {icon:"塑",tag:"非遗技艺",title:"岭南灰塑",image:"museum-assets/gray-plastic-roof.png",detail:"灰塑将石灰、纸筋等材料塑成飞禽瑞兽与花卉故事。屋脊上的蝙蝠、麒麟、仙鹤，分别寄托福气、祥瑞与长寿。",clue:"点击后可前往《灰塑寻踪》，继续辨认三种瑞兽纹样。",spot:"灰塑老屋",secondaryNav:"games",secondaryLabel:"进入灰塑寻踪"},
  {icon:"山",tag:"山海传说",title:"羚羊山",image:"museum-assets/lingyang-mountain.png",detail:"山路把古村、林地与远望串联起来。灵羊传说并非遥远的神话，而是一种关于山村共生、生态守护的想象。",clue:"沿徒步线抵达登山入口，解锁“灵羊守护者”任务。",spot:"登山入口",secondaryNav:"experience",secondaryLabel:"查看徒步体验"}
];

function setMuseum(idx) {
  var d = museumData[idx];
  document.querySelectorAll('[data-museum]').forEach(function(b){ b.classList.remove('selected'); });
  var btn = document.querySelector('[data-museum="'+idx+'"]');
  if (btn) btn.classList.add('selected');
  document.getElementById('stageImg').src = d.image;
  document.getElementById('stageImg').alt = d.title;
  document.getElementById('stageIcon').textContent = d.icon;
  document.getElementById('stageTag').textContent = d.tag;
  document.getElementById('stageTitle').textContent = d.title;
  document.getElementById('stageDetail').textContent = d.detail;
  document.getElementById('stageClue').textContent = d.clue;
  var p = document.getElementById('stagePrimary');
  p.dataset.spot = d.spot;
  p.textContent = '在地图中寻迹 →';
  var s = document.getElementById('stageSecondary');
  s.dataset.nav = d.secondaryNav;
  s.textContent = d.secondaryLabel;
}

document.querySelectorAll('[data-museum]').forEach(function(btn){
  btn.addEventListener('click', function(){ setMuseum(parseInt(this.dataset.museum)); });
});

document.querySelectorAll('[data-museum-nav]').forEach(function(btn){
  btn.addEventListener('click', function(e){
    e.stopPropagation();
    setMuseum(parseInt(this.dataset.museumNav));
    document.getElementById('museum').scrollIntoView({behavior:'smooth',block:'start'});
  });
});

// ── Section navigation ──
var sections = document.querySelectorAll('[data-section]');
var navs = document.querySelectorAll('[data-nav]');

function show(id) {
  sections.forEach(function(s){ s.hidden = s.dataset.section !== id; });
  navs.forEach(function(b){ if (b.dataset.nav) b.classList.toggle('active', b.dataset.nav === id); });
  window.scrollTo({top: 0, behavior: 'smooth'});
}
navs.forEach(function(b){
  b.addEventListener('click', function(){ var t = this.dataset.nav; if (t) show(t); });
});

// ── Map spot interaction ──
document.querySelectorAll('[data-spot]').forEach(function(s){
  s.addEventListener('click', function(){
    var n = this.dataset.spot;
    document.querySelectorAll('.map-spot').forEach(function(m){ m.classList.remove('selected'); });
    var spot = document.querySelector('.map-spot[data-spot="'+CSS.escape(n)+'"]');
    if (spot) spot.classList.add('selected');
    document.getElementById('spotEyebrow').textContent = n;
    document.getElementById('spotTitle').textContent = n;
    document.getElementById('spotDesc').textContent = n+'承载着小㘵村独有的生活记忆与文化线索。到村后可扫描点位二维码，查看图文故事与相关任务。';
    var p = document.getElementById('spotPrimary');
    p.textContent = n === '登山入口' ? '查看徒步体验' : '阅读文化故事';
    p.dataset.nav = n === '登山入口' ? 'experience' : 'museum';
  });
});

// ── Booking scroll ──
document.querySelectorAll('[data-scroll="booking"]').forEach(function(b){
  b.addEventListener('click', function(){
    show('experience');
    setTimeout(function(){ document.getElementById('booking').scrollIntoView({behavior:'smooth'}); }, 100);
  });
});

// ── Form handling ──
var form = document.getElementById('booking');
var bf = form.querySelector('.booking-form');
var ok = form.querySelector('.success');
form.addEventListener('submit', function(e){ e.preventDefault(); bf.hidden = true; ok.hidden = false; });
document.querySelectorAll('[data-reset-form]').forEach(function(b){
  b.addEventListener('click', function(){ bf.hidden = false; ok.hidden = true; form.reset(); });
});
</script>
</body>
</html>
INDEXEOF

# Replace CSS placeholders with actual filenames
sed -i "s|INDEX_CSS_PLACEHOLDER|$INDEX_CSS|g" index.html
sed -i "s|PAGE_CSS_PLACEHOLDER|$PAGE_CSS|g" index.html

echo "=== Step 4: Push to gh-pages ==="
cd ../..
TMPDIR=$(mktemp -d)
cp -r dist/client/* "$TMPDIR/"
cd "$TMPDIR"
git init && git checkout -b gh-pages
git add -A && git commit -m "Deploy $(date +%Y-%m-%d-%H%M)"
git remote add github https://github.com/liao050406-star/xiaobuyunyou.git
git push -f github gh-pages
rm -rf "$TMPDIR"
echo "=== Done! ==="
echo "Site: https://liao050406-star.github.io/xiaobuyunyou/"
