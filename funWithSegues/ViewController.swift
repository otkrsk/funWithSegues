//
//  ViewController.swift
//  funWithSegues
//
//  Created by Nicholas Nuing on 23/04/2016.
//  Copyright © 2016 Nicholas Nuing. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let todoEndpoint: String = "http://jsonplaceholder.typicode.com/todos/1"
		guard let url = NSURL(string: todoEndpoint) else {
			print("Error: cannot create URL")
			return
		}
		
		let urlRequest = NSURLRequest(URL: url)
		
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: config)
		
		let task = session.dataTaskWithRequest(urlRequest) {
			(data, response, error) in
			guard error == nil else {
				print("Error calling GET")
				print(error)
				return
			}
			
			guard let responseData = data else {
				print("Error: did not receive any data")
				return
			}
			do {
				guard let todo = try NSJSONSerialization.JSONObjectWithData(responseData, options: []) as? [String: AnyObject] else {
					print("Error trying to convert data to JSON")
					return
				}
				print("The todo is: " + todo.description)
			} catch {
				print("error")
			}
		}
		
		task.resume()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

