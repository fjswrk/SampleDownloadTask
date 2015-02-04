//
//  ViewController.swift
//  SampleDownloadTask
//
//  Created by sample on 2015/02/03.
//  Copyright (c) 2015年 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDownloadDelegate {

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var rawData:NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.lightGrayColor()
        self.showBtn.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tap(sender: UIButton) {
        
        // 1.NSURLSessionConfigurationの作成
        let identifier = "BackgroundTaskIdentifier"
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(identifier)
        
        // 2.NSURLSessionの作成
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        // 3.NSURLSessionDownloadTaskの作成
        let url = NSURL(string: "http://www.geocities.jp/ezotombo9/Sample/syouzyou.jpg")!
        let task = session.downloadTaskWithURL(url)
        task.resume()
        
        
    }
    
    @IBAction func showImage(sender: UIButton) {
        if self.rawData != nil{
            self.imageView.image = UIImage(data: self.rawData!)
        }
    }

    // 4.結果を受け取る
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        let data = NSData(contentsOfURL: location)!
        if data.length == 0{
            NSLog("Error")
        }else{
            NSLog("Success")
            self.rawData = data
            self.showBtn.hidden = false
        }
    }
    
    // 5.後処理
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        
        if error != nil{
            session.invalidateAndCancel()
        }else{
            session.finishTasksAndInvalidate()
        }
        NSLog("OK")
    }
}

