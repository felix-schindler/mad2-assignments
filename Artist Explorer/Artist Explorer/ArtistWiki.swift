//
//  ViewController.swift
//  Artist Explorer
//
//  Created by Felix Schindler on 16.05.23.
//

import UIKit
import WebKit

class ArtistWiki: UIViewController {
	
	@IBOutlet weak var webView: WKWebView!
	
	var artistName: String = ""

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		if let url = URL(string: "https://de.m.wikipedia.org/wiki?search=\(artistName.url)") {
			webView.load(URLRequest(url: url))
		} else {
			print("[ERROR] wikipedia url is nil")
			fatalError("Failed to open WebView")
		}
	}
}

extension String {
		var url: String {
				return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
		}
}
