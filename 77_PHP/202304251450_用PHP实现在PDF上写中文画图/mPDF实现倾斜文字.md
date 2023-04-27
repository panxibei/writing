mPDF实现倾斜文字

副标题：

英文：

关键字：





`Laravel 10.x`





```
composer require mpdf/mpdf
```



安装的是 `v8.0.16` 版本。

图b04



```
"mpdf/mpdf": "^8.0"
```

图b03



然而会出现错误。

```
Declaration of Mpdf\Mpdf::setLogger(Psr\Log\LoggerInterface $logger) 
must be compatible with Psr\Log\LoggerAwareInterface::setLogger(Psr\Log\LoggerInterface $logger): void 
```

图b01



原因是 `mPDF` 并不与 `psr/log 3.x` 兼容。



图b02



在 `composer.json` 中手动添加一行。

```
"psr/log": "^2.0"
```



就像这样。

图b05



然后更新一下。

```
composer update psr/log
```

图b06



















在 `Mpdf.php` 末尾追加以下代码。

```
vendor\mpdf\mpdf\src\Mpdf.php
```



通过魔改水印函数实现文字倾斜功能。

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





```
// TextWithRotationPlus($wx, $wy, $texte, $angle = 45, $fontsize = 96, $alpha = 0.2, $red = 0, $green = 0, $blue = 0)

// 坐标(40,50)，角度45，字体大小12,Alpha为1,红色(255,0,0)
$mpdf->TextWithRotationPlus(40, 50, $str, 45, 12, 1, 255, 0, 0);

// 坐标(50,70)，角度60，字体大小12,Alpha为1,红色(0,0,255)
$mpdf->TextWithRotationPlus(50, 70, $str, 60, 12, 1, 0, 0, 255);
```

