<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>커피 이야기 | Ryanbucks Korea</title>
<link href="/RYANBUCKS_v1.0/common/css/reset.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_main.css" rel="stylesheet"> <!-- 헤더, 푸터 -->
<link href="/RYANBUCKS_v1.0/common/css/style_coffee_story.css" rel="stylesheet">
<link href="/RYANBUCKS_v1.0/common/img/logo.png" rel="short icon" type="image/ico">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>	<!-- JQuery를 사용하기 위한 라이브러리 -->
</head>
<body>
<jsp:include page="/header.jsp" />
<!-- container -->
<div id="container">
	<!-- 서브 타이틀 -->
	<div class="sub_tit_wrap">
		<div class="sub_tit_inner">
			<h2>
				<img src="/RYANBUCKS_v1.0/non_co_img/sub_title/coffee_story_tit.jpg" alt="커피 이야기">
			</h2>
			<ul class="smap">
				<li>
					<a href="/RYANBUCKS_v1.0/index.jsp">
						<img src="/RYANBUCKS_v1.0/common/img/icon_home.png" alt="홈으로">
					</a>
				</li>
				<li>
					<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
				</li>
				<li class="en">
					<a href="coffee.jsp">COFFEE</a>
				</li>
				<li>
					<img class="arrow" src="/RYANBUCKS_v1.0/common/img/icon_arrow.png" alt="하위메뉴">
				</li>
				<li>
					<a href="javascript:void(0)" class="this">커피이야기</a>
				</li>
			</ul>
		</div>	
	</div>
	<!-- //서브 타이틀 -->
	
	<!-- coffee_story -->
	<div class="coffee_story">
		<dl class="content_tabmenu">
			<dt class="box_bg"></dt>
			
			<!-- tab tab_first tab_01 on, 농장에서 우리의 손으로 -->
			<dt class="tab tab_first tab_01 on">
				<h3>
					<a href="javascript:void(0)" class="test">농장에서 우리의 손으로</a>
				</h3>
			</dt>
			<!-- //tab tab_first tab_01 on -->
			<!-- panel on -->
			<dd class="panel on">
				<!-- coffeeCultivation_wrap, 재배 -->
				<div class="coffeeCultivation_wrap">
					<div class="coffee_content">
						<h3>산지와 농장</h3>
						<div class="cultivation_wrap">
							<!-- cultivation_img : 이미지 -->
							<p class="cultivation_img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffeeCultivation_info_img01.jpg" alt="재배">
							</p>
							<!-- //cultivation_img : 이미지 -->
							<!-- cultivation_text : 텍스트 -->
							<dl class="cultivation_text">
								<dt>"라이언벅스만의 지속가능한 커피 생산"</dt>
								<dd>
									<p class="text1">
										라이언벅스는 온도, 일광, 강우량 등 커피 재배에 이상적인 기후가 <br>
										나타나는 고지대에서 생산된 아라비카 커피만 구매합니다. <br>
										그 이유는 고지대에서 재배된 원두는 <br>
										풍부한 풍미와 세련된 바디감과 산미를 가지고 있기 때문입니다. <br>
										이를 위해 라이언벅스는 농장과 농부들의 곁에서 커피 경작을 함께 연구합니다. <br>
										라이언벅스 커피는 각 산지의 커피가 가지고 있는 최상의 풍미와 더불어 <br>
										산지의 농부와 라이언벅스의 노력이 담겨있습니다.
									</p>
								</dd>
							</dl>
							<!-- //cultivation_text : 텍스트 -->
						</div>
					</div>
				</div>
				<!-- //coffeeCultivation_wrap, 재배 -->
				<!-- coffeeObtain_wrap, 조달 -->
				<div class="coffeeObtain_wrap">
					<div class="coffee_content">
						<h3>공급과 거래</h3>
						<p class="bigImg01">
							<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffeeObtain_bigImg01.jpg" alt="조달">
							<span>
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffeeObtain_bigImg02.png" alt="조달">
							</span>
						</p>
						<dl class="obtainInfo_text">
							<dt>"라이언벅스만의 윤리적인 커피 구매"</dt>
							<dd>
								<p class="text1">
									라이언벅스는 언제나 세계에서 가장 훌륭한 커피를 구매합니다. <br>
									이를 위해 라이언벅스는 커피 전문가는 한 사람당 1년에 25만 잔의 이상의 커피를 
									테이스팅 하며, <br>
									산지의 농부와 농장을 직접 방문합니다. <br>
									농부들과의 지속적인 협업과 거래를 통해 매년 고품질의 커피를 생산하고 <br>
									윤리적인 구매를 위한 활동을 지속합니다.									
								</p>
							</dd>
						</dl>
					</div>
				</div>
				<!-- //coffeeObtain_wrap, 조달 -->
				<!-- coffeeRoasting_wrap, 로스팅 -->
				<div class="coffeeRoasting_wrap">
					<div class="coffee_content">
						<h3>라이언벅스 로스트 철학</h3>
						<div class="coffeeRoasting_info">
							<p class="img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffeeRoasting_info_img01.jpg" alt="끝없는 공부, 그리고 연구.">
							</p>
							<dl class="text">
								<dt>
									<h3 class="title">"생두가 가진 잠재된 맛을 최대한 발현"</h3>
								</dt>
								<dd>
									<p class="text1">
										단단한 생두가 풍미 가득하고 향기로운 원두가 되려면, 섬세한 로스팅 기술이 필요합니다. <br>
										라이언벅스의 로스팅은 1971년부터 시작되었습니다. <br>
										오랜 세월 경험을 쌓아온 최고의 로스팅 기술은 예술이자 과학입니다. 									
									</p>
									<p class="text1">
										로스팅 과정에서 강한 열을 가하면 생두에서 수분이 빠져나가고, <br>
										당분과 전분이 오일 성분으로 바뀝니다. <br>
										라이언벅스 커피의 풍부한 맛과 향은 대부분 이 오일에서 나옵니다. <br>
										열이 너무 강하면 원두가 너무 어둡게 로스팅 되고 커피의 오일이 너무 많이 타버립니다. <br>
										반대로 열이 너무 약하면 커피의 오일이 충분히 방출되지 않고 시큼한 풍미만 남습니다. <br>
										그래서 생두가 가진 본연의 풍미를 최대한 발현시킨 커피 한 잔을 얻기 위해, <br>
										커피마다 로스팅의 시간과 온도를 약간씩 다르게 조절해야 합니다.
									</p>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<!-- //coffeeRoasting_wrap, 로스팅 -->
				<!-- coffeeBlending_wrap, 블렌딩 -->
				<div class="coffeeBlending_wrap">
					<div class="coffee_content">
						<div class="blending_text">
							<h3 class="blending">엄격한 비율로 완성된 블렌드</h3>
							<dl class="blendingInfo_text">
								<dt>"최상의 블렌드를 위한 노력"</dt>
								<dd>
									<p class="text1">
										라이언벅스는 커피잔에 담긴 최종 결과물이 어떠해야 하는지를 가장 먼저 생각합니다. <br>
										"강조하고 싶은 풍미는 무엇인가, 무엇이 느껴져야 하는가?" <br>
										그리고 풍부한 경험을 가진 라이언벅스 팀에서 각각의 블렌드를 개발하고 제조합니다. <br>
										예를 들어, 풍성한 저녁식사에 풍미를 더하기 위해 블렌드를 만들고, <br>
										싱글 오리진 커피에서 찾아볼 수 없는 매우 복잡하고 완성된 맛의 커피를 만들기도 하고, <br>
										계절에 어울리는 블렌드를 개발합니다. <br>
										또한, 고객과 파트너들이 기억하고 있는 인기 블렌드의 특징을 생생하게 되살려내기도 합니다. <br>
										이러한 최상의 블렌딩 기술은 전문가들의 경력을 합친 75년이라는 숫자가 말해줍니다. 
									</p>
								</dd>
							</dl>
						</div>
						<p class="blending_img">
							<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffeeBlending_img01.jpg" alt="블렌딩">
						</p>
					</div>
				</div>
				<!-- //coffeeBlending_wrap, 블렌딩 -->
			</dd>
			<!-- //panel on -->
			
			
			<!-- tab tab_02 on, 최상의 아라비카 원두 -->
			<dt class="tab tab_02">
				<h3>
					<a href="javascript:void(0)">최상의 아라비카 원두</a>
				</h3>
			</dt>
			<!-- panel on -->
			<dd class="panel">
				<!-- higherAravica_wrap -->
				<div class="higherAravica_wrap">
					<div class="coffee_content">
						<h3>최상의 아라비카 원두</h3>
						<dl class="higherAravica">
							<dt>
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_bigImg01.jpg" alt="">
							</dt>
							<dd>
								<span class="bigImg_bg">
									<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_bigImg_bg.png" alt="">
								</span>
								<dl class="text">
									<dt>최고의 커피는 최상의 원두로부터</dt>
									<dd>
										라이언벅스 아라비카 원두는 고품질, 그 이상의 의미를 갖습니다. <br>
										최상의 품질을 위한 최선의 노력들이 모든 단계에서 이뤄집니다. <br>
										과연 라이언벅스는 최상의 원두를 위해 어떤 노력을 하고 있을까요? 
									</dd>
								</dl>
							</dd>
						</dl>
					</div>
					<!-- //higherAravica_wrap -->
					<!-- aravica_info_01 -->
					<div class="aravica_info_01">
						<div class="coffee_content">
							<p class="img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_info_img01.jpg" alt="">
							</p>
							<dl class="text">
								<dt>"고품질을 위한, 고지대를 향한"</dt>
								<dd>
									<p>
										고품질의 아라비카 원두는 고도가 높은 곳에서 재배됩니다. <br>
										큰 일교차로 당도가 높고 밀도가 단단한 원두는 깊고 복합적인 풍미를 냅니다.
									</p>
								</dd>
							</dl>
						</div>
					</div>
					<!-- //aravica_info_01 -->
					<!-- aravica_info_02 -->
					<div class="aravica_info_02">
						<div class="coffee_content">
							<dl class="text">
								<dt>"커피 생산, 그 이상을 위한 끊임없는 노력"</dt>
								<dd>
									<p>
										라이언벅스는 커피 농부들이 좋은 품질의 커피를 재배할 수 있도록 그들을 돕고 있습니다. <br>
										전 세계 주요 커피 재배 지역에 10개의 농민 지원 센터가 운영되고 있으며 <br>
										스타벅스 전문가드이 커피 경작을 위한 연구를 하여 농부들에게 무료로 제공하고 있습니다.
									</p>
								</dd>
							</dl>
							<p class="img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_info_img02.jpg" alt="">
							</p>
						</div>
					</div>				
					<!-- //aravica_info_02 -->
					<!-- aravica_info_03 -->
					<div class="aravica_info_03">
						<div class="coffee_content">
							<p class="img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_info_img03.jpg" alt="">
							</p>
							<dl class="text">
								<dt>"커피 농가와 지속적인 관계"</dt>
								<dd>
									<p>
										커피 농가의 미래가 곧 커피의 미래입니다. <br>
										이를 위해 라이언벅스는 커피 농부들과 공정한 커피 거래를 하며 <br>
										커피 농가와 지역사회가 커피 산업으로 지속가능한 삶을 영위하도록 노력하고 있습니다. 
									</p>
								</dd>
							</dl>
						</div>
					</div>
					<!-- //aravica_info_03 -->
					<!-- aravica_info_04 -->
					<div class="aravica_info_04">
						<div class="coffee_content">
							<dl class="text">
								<dt>"까다롭고 엄격한 수확 과정"</dt>
								<dd>
									<p>
										라이언벅스는 잘 익은 커피 열매만 수확합니다. <br>
										그리고 크기, 색깔 및 밀도를 기준으로 최상으이 열매를 한 번 더 골라냅니다. <br>
										보다 까다롭고 엄격한 수확 과정이 곧 훌륭한 커피를 탄생시킵니다. <br>
										까다롭고 엄격한 수확 과정을 거쳐야 비로소 최상의 커피 맛을 구현할 수 있습니다.
									</p>
								</dd>
							</dl>
							<p class="img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_info_img04.jpg" alt="">
							</p>
						</div>
					</div>
					<!-- //aravica_info_04 -->
					<!-- aravica_info_05 -->
					<div class="aravica_info_05">
						<div class="coffee_content">
							<p class="img">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/higherAravica_info_img05.jpg" alt="">
							</p>						
						<dl class="text">
							<dt>"고품질의 커피를 위한 수차례의 테이스트"</dt>
							<dd>
								<p>
									고품질 커피를 위한 라이언벅스의 노력은 <br>
									농부와 함께 생산하며 수차례의 품질 체크를 통해 완성해 갑니다. <br>
									고품질의 커피 생산은 농부에게 높은 가격으로 돌아가고 <br>
									고객들에게 풍성한 풍미의 커피로 제공됩니다.
								</p>
							</dd>
						</dl>
						</div>
					</div>
					<!-- //aravica_info_05 -->
				</div>
			</dd>
			<!-- //panel on -->
			
			<!-- tab tab_03, 라이언벅스 로스트 스펙트럼 -->
			<dt class="tab tab_03">
				<h3>
					<a href="javascript:void(0)">스타벅스 로스트 스펙트럼</a>
				</h3>
			</dt>
			<dd class="panel">
				<div class="coffee_content">
					<div class="cfs01_full_top">
						<h3>라이언벅스 로스트 스펙트럼</h3>
						<p class="big_img">
							<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffee_story_bigImg01.jpg" alt="스타벅스 로스트 스펙트럼">
						</p>
						<h3 class="title">"끊임없는 연구와 마스터 정신"</h3>
						<p class="t1">
							원두는 온도와 시간의 균형으로 본연의 향과 풍미가 최상의 수준으로 발현됩니다. <br>
							라이언벅스는 끊임없는 연구와 마스터 정신이 깃든 세 가지 로스팅 기법을 보유하고 있습니다. <br>
							(블론드 로스트, 미디엄 로스트, 다크 로스트) <br>
							당신의 취향의 맞는 로스트를 찾아 커피의 풍미를 더 풍부하게 즐겨보세요
						</p>
					</div>
				</div>
				<div class="cfs01_bottom">
					<div class="coffee_content">
						<ul class="cfs01_bottom_list">
							<li>
								<p class="img">
									<img src="/RYANBUCKS_v1.0/non_co_img/coffee/subtle_mellow.jpg" alt="은은하고 부드러운 맛 Subtle & Mellow">
									<span class="dim_txt1">
										은은하고 부드러운 맛
										<span class="en">Subtle & Mellow</span>
									</span>
								</p>
								<dl class="cfs01_text">
									<dt>
										<h4>감각을 깨워주는 향긋한 블론드 로스트 커피</h4>
									</dt>
									<dd>
										<p>
											라이언벅스 블론드 로스트는 향긋함, 은은한 산미, <br>
											부드러운 단맛이 느껴지는 산뜻한 커피입니다.
										</p>
									</dd>
								</dl>
							</li>
							<li>
								<p class="img">
									<img src="/RYANBUCKS_v1.0/non_co_img/coffee/smooth_balanced.jpg" alt="부드럽고 균형 잡힌 맛 Smooth & Balanced">
									<span class="dim_txt2">
										부드럽고 균형 잡힌 맛
										<span class="en">Smooth & Balanced</span>
									</span>
								</p>
								<dl class="cfs01_text">
									<dt>
										<h4>부드럽고 균형 잡힌 미디엄 로스트 커피</h4>
									</dt>
									<dd>
										<p>
											부드러움과 균형 있는 맛과 풍미를 선사하는 미디엄 로스트는 <br>
											라이언벅스의 변함없는 커피의 맛을 보여줍니다.
										</p>
									</dd>
								</dl>
							</li>
							<li>
								<p class="img">
									<img src="/RYANBUCKS_v1.0/non_co_img/coffee/bold_robust.jpg" alt="진하고 강한 맛 Bold & Robust">
									<span class="dim_txt3">
										진하고 강한 맛
										<span class="en">Bold & Robust</span>
									</span>
								</p>
								<dl class="cfs01_text">
									<dt>
										<h4>강한 풍미로 입안을 가득 채우는 다크 로스트 커피</h4>
									</dt>
									<dd>
										<p>
											라이언벅스 다크 로스트는 묵직한 바디감과 긴 여운의 강한 풍미로 <br>
											많은 커피 팬들이 사랑하는 커피입니다.
										</p>
									</dd>
								</dl>
							</li>
						</ul>
					</div>
				</div>
			</dd>
			<!-- tab tab_04, 라이언벅스 디카페인 -->
			<dt class="tab tab_04 tab_last">
				<h3>
					<a href="javascript:void(0)">라이언벅스 디카페인</a>
				</h3>
			</dt>
			<dd class="panel">
				<div class="coffee_content decafeStroy">
					<div class="cfs01_full_top">
						<h3>라이언벅스 디카페인 커피</h3>
						<p class="big_img">
							<img src="/RYANBUCKS_v1.0/non_co_img/coffee/coffee_decafe_bigImg01.jpg" alt="라이언벅스 로스트 스펙트럼">
						</p>
						<h3 class="title">
							<img src="/RYANBUCKS_v1.0/non_co_img/coffee/tle_decafe.jpg" alt="Our newest coffee to love">
						</h3>
						<h4 class="title2">"언제나 풍부한 커피를 즐길 수 있는 디카페인"</h4>
						<p class="t2">
							부드럽고 편안한 아침을 마주하고 싶은 순간, 바쁘게 보낸 하루의 마무리 즈음, <br>
							혹은 커피를 많이 마시게 되는 날이라면 라이언벅스 디카페인 커피를 추천드립니다. <br><br>
							디카페인으로 즐길 수 있는 다양한 라이언벅스 음료를 만나 보세요.
						</p>
					</div>
					<div class="decafeStory">
						<div class="top">
							<span class="imgBox">
								<img src="/RYANBUCKS_v1.0/non_co_img/coffee/decafeImg1.jpg" alt="">
							</span>
							<dl>
								<dt>"커피의 맛과 풍미는 변함없는 라이언벅스 디카페인 커피"</dt>
								<dd>
									라이언벅스의 디카페인 커피는 식품위생법 등에서 허용하는 디카페인기준에 적합한 <br>
									CO <sub>2</sub>
									추출방식으로 만들어집니다. 화학제품은 사용하지 않고 오직 CO
									<sub>2</sub>
									와 스팀만을 사용하여 <br>
									원두 속의 카페인을 제거하는 방식으로 만들며, 카페인 부담은 줄이면서 라이언벅스 커피만의 <br>
									뛰어난 맛과 풍미는 그대로 즐기실 수 있습니다.
								</dd>
							</dl>
						</div>
						<div class="bottom">
							<h5>일반 커피와 디카페인 커피의 차이는 무엇인가요?</h5>
							<p>
								라이언벅스 디카페인 커피는 화학제품을 쓰지 않고 오직 카페인만을 제거하는 CO <sub>2</sub>
								방식으로 만들어집니다.
							</p>
							<p>
								일반 커피 대비 맛과 향의 차이가 거의 없는 것이 가장 큰 특징입니다.
							</p>
							<div class="co2">
								<h6>
									<i>
										<img src="/RYANBUCKS_v1.0/non_co_img/coffee/ico_q.png" alt="">
									</i>
									라이언벅스 디카페인 커피를 만드는 CO <sub>2</sub>
									추출 방식을 소개합니다.
								</h6>
								<ul>
									<li class="how1">
										<span class="imgBox">
											<img src="/RYANBUCKS_v1.0/non_co_img/coffee/decafeCo21.jpg">
										</span>
										<p>
											<span class="num">1</span>
											<span class="summary">생두를 깨끗하게 세척한 뒤, 증기와 물을 이용해 생두를 불립니다.</span>
										</p>
									</li>
									<li class="how2">
										<span class="imgBox">
											<img src="/RYANBUCKS_v1.0/non_co_img/coffee/decafeCo22.jpg">											
										</span>
										<p>
											<span class="num">2</span>
											<span class="summary">카페인을 추출할 수 있는 스테인리스 스틸 용기에 불린 생두를 넣습니다.</span>
										</p>
									</li>
									<li class="how3">
										<span class="imgBox">
											<img src="/RYANBUCKS_v1.0/non_co_img/coffee/decafeCo23.jpg">
										</span>
										<p>
											<span class="num">3</span>
											<span class="summary">
												액체 상태의 CO <sub>2</sub>
												가 높은 압력에서 생두와 접촉하여 생두의 카페인만 <br class="p">
												추출하는 역할을 하고 커피의 맛과 향은 그대로 보존됩니다.
											</span>
										</p>
									</li>
									<li class="how4">
										<span class="imgBox">
											<img src="/RYANBUCKS_v1.0/non_co_img/coffee/decafeCo24.jpg">
										</span>
										<p>
											<span class="num">4</span>
											<span class="summary">
												디카페인 공정을 마친 생두는 라이언벅스만의 탁월한 로스팅과 <br class="p">
												커핑을 거쳐 스타벅스 디카페인 에스프레소 로스트 원두로 탄생합니다.
											</span>
										</p>
									</li>
								</ul>
							</div>
						</div>
						
					</div>
				</div>			
			</dd>
		</dl>
	</div>
	<!-- //coffee_story -->
</div>	
<!-- //container -->
<jsp:include page="/footer.jsp" />
	<script>
		// 작은 썸네일 클릭 시 클릭된 이미지를 큰 썸네일에 표시
		$(document).ready(function () {
			$(".tab").on("click", function() {		// 클래스명이 "tab"인 요소에 클릭 이벤트가 발생하면
				$(".tab").removeClass("on");		// 클래스명이 "tab"인 요소의 클래스에서 "active"를 제거하고
				$(this).addClass("on");				// 클릭 이벤트가 발생한 요소의 클래스에 "active" 추가
				$(".panel").removeClass("on");
				$(this).next("dd").addClass("on"); 
			});
		});
	</script>
</body>
</html>
