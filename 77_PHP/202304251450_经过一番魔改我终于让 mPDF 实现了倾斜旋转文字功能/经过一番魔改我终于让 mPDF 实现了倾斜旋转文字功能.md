经过一番魔改我终于让 mPDF 实现了倾斜旋转文字功能

副标题：经过一番魔改我终于让 mPDF 实现了倾斜旋转文字功能

英文：after-magic-modifications-i-finally-achieve-rotate-text-function-with-mpdf

关键字：mpdf,pdf,fpdf,fpdi,tcpdf,rotate,倾斜,旋转,文字,php,laravel



有个项目其中一些细节要求比较刁钻。

大概意思是需要在某些文档或图片上再绘图画画，比如画直线、画圆圈等线条或形状，另外当然还要写些文字啥的。

在此期间，我找过很多 `PHP` 库（俗称轮子），不是这不行，就是那不行，把人给折腾得半死。

我也不知道怎么会有那么多的轮子，什么 `FPDF` 、`FPDI` 、`TCPDF` ，还有其他一大堆第三方轮子，让我眼花缭乱，无从下手。

你看哈，要么这个不支持中文文字显示，要么那个画不了想要的图形，要么剩下那些被魔改过的实现起来超级复杂，总之没一个省心的。

经过数周的折腾研究，尝遍了各种轮子的酸甜苦辣，最终在其中找到了 `mPDF` 。



是的，它还是一个轮子！

有小伙伴会问了，这个 `mPDF` 不一样也是和前面说的那几个差不多嘛，有啥特殊的？

其实吧，这个 `mPDF` 也是基于 `FPDF` 和 `HTML2FPDF` 的一个 `PHP` 库，只不过它要比前几样要高级一些。

比如支持 `UTF-8` 编码，这就可以很好地支持中文等非拉丁文字的显示。

除此之外它也可以画画，也就是可以绘制各种图形。

可以说它基本上满足了我的要求，但是，但是它并不支持文字的倾斜（非字体斜体）显示。

图01



有人说了，你也没提要什么文字倾斜啊？

不好意思是我忘说了，其实前面介绍的那几个轮子有的就支持这功能，总之我是想要这种效果的，确切地说是文字的旋转显示，包括图形旋转等。

那么 `mPDF` 可以做到文字倾斜的效果吗？

答案是不能！



咳咳……请把板砖放下，请听我说完。

其实起初我都整得差不多了，`mPDF` 啥都好，就是这个功能不行，找了很多网站资料也没个所以然，我也挺郁闷的。

不过后来经过我自己的研究，发现了一种可以实现文字倾斜效果的另类方法。

图02



实现原理暂且按下不表，先说下 `mPDF` 在通常情况下安装使用时我踩到的坑。



实验环境概览：

* `PHP` - `8.1`
* `Laravel 10.x`



安装 `mPDF` ，这个没花样，按官网的来。

```
composer require mpdf/mpdf
```



这里 `Composer` 安装的 `mPDF` 是 `v8.0.16` 版本。

注意，安装程序会根据你环境中的 `PHP` 版本来判断需要安装哪一版本的 `mPDF` 。

如果你使用的是 `PHP 8.2` ，那么它会给你安装 `v8.1.x` 。

图03



我这边，在 `composer.json` 中程序自动写入的也是 `8.0` 版本。

```
"mpdf/mpdf": "^8.0"
```

图04



安装顺利完成，写几行测试代码试试吧。

```
<?php

require_once __DIR__ . '/vendor/autoload.php';

$mpdf = new \Mpdf\Mpdf();
$mpdf->WriteHTML('<h1>Hello world!</h1>');
$mpdf->Output();
```



上面是拿官网现成的示例代码，一切OK！

然而将这些拢共两三行代码放到 `Laravel` 中就会出现错误。

```
Declaration of Mpdf\Mpdf::setLogger(Psr\Log\LoggerInterface $logger) 
must be compatible with Psr\Log\LoggerAwareInterface::setLogger(Psr\Log\LoggerInterface $logger): void 
```

图05



这什么情况，怎么和 `psr/log` 搞上了。

虽然我不是太懂这个，但是后来查了网上，原因是 `mPDF` 并不与 `psr/log 3.x` 兼容（注意是 `3.x` 这个版本）。

论坛里有大神更多的解释，参考链接分享在此。

> https://stackoverflow.com/questions/74433569/mpdf-mpdf-loggerawareinterface-incompatibility-with-psr-log-in-php-8-1-12/74442440#74442440

图06



总之一句话，使用 `psr/log 2.x` 就行了。

根据大神指导，在 `composer.json` 文件的 `require` 项中手动添加一行（文件里可能没有这一行）。

```
"psr/log": "^2.0"
```



就像这个样子。

图07



然后手动更新一下。

```
composer update psr/log
```

图08



可以看到 `psr/log` 从 `3.0.0` 降到了 `2.0.0` 。

测试一下，`mPDF` 已经可以在 `Laravel` 下正常工作了。

图09



最后把我的劳动成果放在这里。

**`mPDF` 实现文字倾斜功能源代码(168K)(适用于v8.0)**

下载链接：https://pan.baidu.com/s/1_jRxK8UOK4eTsO-uI-dq1A

提取码：9sgj



以下为实现方法和源代码。

===================================

注意，以下为付费内容。



在 `Mpdf.php` 的末尾追加以下代码。

如果你使用的是 `Laravel` 框架，那么 `Mpdf.php` 应该在这里。

```
vendor\mpdf\mpdf\src\Mpdf.php
```



通过魔改水印函数实现文字倾斜功能。

我修改的部分代码即实现了前面介绍的效果，如果你还有其他特殊要求可自行修改。

```
	/**
	 * @param int $wx
	 * @param int $wy
	 * @param string $texte
	 * @param int $fontsize
	 * @param float $alpha
	 * @param int $red
	 * @param int $green
	 * @param int $blue
	 * @return string
	 */
	// 通过魔改watermark函数搞定文字倾斜功能
	function TextWithRotationPlus($wx, $wy, $texte, $angle = 45, $fontsize = 96, $alpha = 0.2, $red = 0, $green = 0, $blue = 0)
	{
		if ($this->PDFA || $this->PDFX) {
			throw new \Mpdf\MpdfException('PDFA and PDFX do not permit transparency, so mPDF does not allow Watermarks!');
		}

		if (!$this->watermark_font) {
			$this->watermark_font = $this->default_font;
		}

		$this->SetFont($this->watermark_font, "B", $fontsize, false); // Don't output
		$texte = $this->purify_utf8_text($texte);

		if ($this->text_input_as_HTML) {
			$texte = $this->all_entities_to_utf8($texte);
		}

		if ($this->usingCoreFont) {
			$texte = mb_convert_encoding($texte, $this->mb_enc, 'UTF-8');
		}

		// DIRECTIONALITY
		if (preg_match("/([" . $this->pregRTLchars . "])/u", $texte)) {
			$this->biDirectional = true;
		} // *OTL*

		$textvar = 0;
		$save_OTLtags = $this->OTLtags;
		$this->OTLtags = [];
		if ($this->useKerning) {
			if ($this->CurrentFont['haskernGPOS']) {
				$this->OTLtags['Plus'] .= ' kern';
			} else {
				$textvar = ($textvar | TextVars::FC_KERNING);
			}
		}

		/* -- OTL -- */
		// Use OTL OpenType Table Layout - GSUB & GPOS
		if (isset($this->CurrentFont['useOTL']) && $this->CurrentFont['useOTL']) {
			$texte = $this->otl->applyOTL($texte, $this->CurrentFont['useOTL']);
			$OTLdata = $this->otl->OTLdata;
		}
		/* -- END OTL -- */
		$this->OTLtags = $save_OTLtags;

		$this->magic_reverse_dir($texte, $this->directionality, $OTLdata);

		$this->SetAlpha($alpha);

		$this->SetTColor($this->colorConverter->convert(0, $this->PDFAXwarnings));

		$szfont = $fontsize;
		$loop = 0;
		$maxlen = (min($this->w, $this->h) ); // sets max length of text as 7/8 width/height of page

		while ($loop == 0) {
			$this->SetFont($this->watermark_font, "B", $szfont, false); // Don't output
			$offset = ((sin(deg2rad($angle))) * ($szfont / Mpdf::SCALE));

			$strlen = $this->GetStringWidth($texte, true, $OTLdata, $textvar);
			if ($strlen > $maxlen - $offset) {
				$szfont --;
			} else {
				$loop ++;
			}
		}

		$this->SetFont($this->watermark_font, "B", $szfont - 0.1, true, true); // Output The -0.1 is because SetFont above is not written to PDF

		// Repeating it will not output anything as mPDF thinks it is set
		$adj = ((cos(deg2rad($angle))) * ($strlen / 2));
		$opp = ((sin(deg2rad($angle))) * ($strlen / 2));

		//$wx = ($this->w / 2) - $adj + $offset / 3;
		//$wy = ($this->h / 2) + $opp;

		$this->Rotate($angle, $wx, $wy);
		
		$this->SetTextColor($red, $green, $blue);
		
		$this->Text($wx, $wy, $texte, $OTLdata, $textvar);
		$this->Rotate(0);
		$this->SetTColor($this->colorConverter->convert(0, $this->PDFAXwarnings));

		$this->SetAlpha(1);
	}
```



调用倾斜文字功能示例。

```
// 坐标(40,50)，角度45，字体大小12,Alpha为1,红色(255,0,0)
$mpdf->TextWithRotationPlus(40, 50, $str, 45, 12, 1, 255, 0, 0);

// 坐标(50,70)，角度60，字体大小12,Alpha为1,蓝色(0,0,255)
$mpdf->TextWithRotationPlus(50, 70, $str, 60, 12, 1, 0, 0, 255);
```



**将技术融入生活，打造有趣之故事**

网管小贾 / sysadm.cc