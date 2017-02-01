//
//  ViewController.swift
//  AnimationSwift
//
//  Created by nisum on 11/21/16.
//  Copyright © 2016 nisum. All rights reserved.
///ghjdcgkhsjkckj
//

import UIKit

import AVFoundation
import SpriteKit



class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
 
    
    var isRepeteZoomIn: Int = 0
    var isRepeteZoomOut: Int = 0

    var intvalue : Int = 0
    

    var audioPlayer:AVAudioPlayer!

    var viewWidth: CGFloat = 0
    var viewHeight: CGFloat = 0
    
    var kOneFifthWidth: CGFloat = 0
    var userContainerView = UIView()
    var kFirstPerson = UIImageView()
    
    var image: UIImage?
    var image1: UIImage?

    var winnerImage: UIImage?
    var  starImage2 : UIImageView?
    var relativeX : CGFloat = 0
    
    var _collectionView: UICollectionView!
    var xPossionContainer : NSMutableArray = NSMutableArray()
    var collecitonData : NSArray!
    var dataContainer : NSMutableArray   =   NSMutableArray()
    
    var zoomIndataContainer : NSMutableArray   =   NSMutableArray()
    var zoomOutdataContainer : NSMutableArray   =   NSMutableArray()

    
    var kCollectCoinImg = UIImageView()
    
    var kUserCoinImg = UIImageView()
    var kuser = UIImageView()
    var kFirstUserCoinImg = UIImageView()
    
    var kUserCoordinates : CGPoint?
    var kViewCenterCoordinates : CGPoint?
    var kFirstPersonCoordinates : CGPoint?
    var cellPoint: CGPoint?

    var timer       = NSTimer()
    var timer1      = NSTimer()
    var tempTimer   = NSTimer()
    
    var collectCoinTimerZoomIn = NSTimer()
    var collectCoinTimerZoomOut = NSTimer()
    var collectCoinTimerZoomouthiddenCenter = NSTimer()
    var collectCoinTimerZoomoutComplete = NSTimer()

    
    var tempImge = UIImageView()
    var tempUserImage = UIImageView()
    var winnerImageView = UIImageView()
    var tempWinnerImageView = UIImageView()


    
    var label = UILabel()
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
      /*  let jeremyGif = UIImage.gifImageWithName("funny")
        let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
        view.addSubview(imageView)
 */
        
        viewWidth = self.view.frame.width
        viewHeight = self.view.frame.height
        collecitonData = NSArray(objects:"1","2","3","4","5")
        kOneFifthWidth = viewWidth/5-25;
        for contact in collecitonData{
    
            print(contact)
            let tempDict : NSMutableDictionary = NSMutableDictionary()
             if contact.isEqualToString("1") || contact.isEqualToString("3") {
                
                tempDict.setValue(contact, forKey: "data")
                tempDict.setValue(false, forKey: "isActive")
                dataContainer.addObject(tempDict)
                
                }
            else{
                
                tempDict.setValue(contact, forKey: "data")
                tempDict.setValue(true, forKey: "isActive")
                dataContainer.addObject(tempDict)
            }

        }
        print(dataContainer)
        addButtonToView()
        addUserCustomView()
        addCollectionView()
    }
    

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func addUserCustomView() {
        

        kUserCoinImg.image = UIImage(named: "person.png")
        kuser.frame = CGRectMake(viewWidth/2-25, 0, 50, 50)
        kuser.image = UIImage(named: "person.png")
        
        let rect = CGRect(x: 0.0, y: viewHeight-100, width: viewWidth, height: 50.0)
        userContainerView = UIView(frame: rect)
        userContainerView.backgroundColor = UIColor.clearColor()
       
        userContainerView.addSubview(kuser)
      
        let point: CGPoint = CGPoint(x:kuser.frame.origin.x+25,y:viewHeight-100)
        kUserCoordinates = point
        self.view.addSubview(userContainerView)
        kViewCenterCoordinates = self.view.center
        
        
    }
    
    func addButtonToView() {
        
        let zoomInBtn    =   UIButton(type: .Custom)
        zoomInBtn.frame  =   CGRectMake(10,15, 80, 40)
        zoomInBtn.userInteractionEnabled =   true
        zoomInBtn.setTitleColor(UIColor.greenColor(), forState: .Normal)
        zoomInBtn.addTarget(self, action: #selector(zoomInBtnTapped), forControlEvents: .TouchUpInside)
        zoomInBtn.setTitle("ZoomIn", forState: .Normal)
        self.view.addSubview(zoomInBtn)

      //  zoomInBtn.setImage(UIImage(named: "message.png"), forState: .Normal)

        let zoomOutBtn    =   UIButton(type: .Custom)
        zoomOutBtn.frame  =   CGRectMake(viewWidth-100,15, 80, 40)
        zoomOutBtn.userInteractionEnabled =   true
        zoomOutBtn.setTitleColor(UIColor.greenColor(), forState: .Normal)
        zoomOutBtn.addTarget(self, action: #selector(zoomOutBtnTapped), forControlEvents: .TouchUpInside)
        zoomOutBtn.setTitle("ZoomOut", forState: .Normal)
        self.view.addSubview(zoomOutBtn)

        /*
        let zoomOutBtn: UIButton = UIButton(frame: CGRect(x: viewWidth-80, y: 10, width: 80, height: 40))
        zoomOutBtn.backgroundColor = UIColor.green
        zoomOutBtn.setTitle("Start", for: .normal)
        zoomOutBtn.addTarget(self, action: #selector(zoomOutBtnTapped), for: .touchUpInside)
        self.view.addSubview(zoomOutBtn)
        */
        
        
    }
    func addCollectionView(){
        
        kOneFifthWidth = viewWidth/5-25
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let rect = CGRect(x: 30.0, y: 60.0, width: viewWidth, height: 50.0)
        _collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        _collectionView.dataSource = self
        _collectionView.delegate = self
        _collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        _collectionView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(_collectionView)
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataContainer.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyCell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        
        var relativeX : CGFloat
       
        let starImage2 = UIImageView()
        starImage2.frame = CGRectMake(0, 0, 50, 50)
        cell.contentView.addSubview(starImage2)
        
        relativeX = cell.frame.origin.x - _collectionView.contentOffset.x + starImage2.frame.origin.x;
        print(relativeX)
        let tempDict : NSDictionary = dataContainer.objectAtIndex(indexPath.row) as! NSDictionary
        
        let isCheck : Bool = (tempDict.objectForKey("isActive")?.boolValue)!
        if isCheck == false {
            
            image = UIImage(named: "person_Deselect.png")
        }
        else{
            image = UIImage(named: "person.png")
        }
        starImage2.image = image
        cellPoint = CGPoint(x: relativeX+30,y: _collectionView.frame.origin.y)
        kUserCoordinates = cellPoint
        print(kUserCoordinates)
        
        if xPossionContainer.count == collecitonData.count {
            
        }
        else{
            
            let pointObj = NSValue(CGPoint: kUserCoordinates!)
            xPossionContainer.addObject(pointObj)

        }
        print(xPossionContainer)
        
//        kFirstUserCoinImg.image = image
//        self.view.addSubview(kFirstUserCoinImg)
//        kFirstUserCoinImg.hidden = true
        
        //  CGRect starFrame1;
       // UIImageView *starImage2;
        
        return cell
    }
    func zoomInBtnTapped() -> Void {
        
        
        if isRepeteZoomIn == 0 {
            
            isRepeteZoomIn = 1
            addPushAnimationZoomIn(true, aView: kUserCoinImg)
            //return
        }
     
    }
    
    func addPushAnimationZoomIn(directionBool: Bool, aView: UIView) -> Void{
    
        let animation = CATransition()
        animation.duration = 1.5
        animation.delegate = self
        animation.type = kCATransitionPush
        if directionBool == true{
            animation.subtype = kCATransitionFromTop
        }
        else{
            animation.subtype = kCATransitionFromLeft
        }
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeRemoved
        aView.layer.addAnimation(animation, forKey: "SwitchToView")
        
        kFirstUserCoinImg.hidden = false
        var x:Int = 0

        for contact in dataContainer{
            
            print(contact)
            var kDict   =   NSMutableDictionary()
            kDict = contact as! NSMutableDictionary
            print(kDict)
            let isCheck : Bool  = (kDict.objectForKey("isActive")?.boolValue)!
            if isCheck == false {
                x += 1
                print(x)
            }
            else{
            
                
                image = UIImage(named: "testCoin")
               // image = UIImage.gifImageWithName("funny")
               // image = UIImage.gifImageWithName("single-coin-going")
               // image = UIImage.gifImageWithName("Giff")

                kFirstUserCoinImg = UIImageView()
                kFirstUserCoinImg.image = image
                zoomIndataContainer.addObject(kFirstUserCoinImg)
                self.view.addSubview(kFirstUserCoinImg)
                kFirstUserCoinImg.alpha = 1.0
                let val : NSValue = xPossionContainer.objectAtIndex(x) as! NSValue
                x += 1
                print(x)
                print(val)
                let point: CGPoint = val.CGPointValue()
                kFirstUserCoinImg.frame = CGRectMake(point.x-20, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(1.5)
                kFirstUserCoinImg.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
                UIView.commitAnimations()
            }

        }
        
        image1 = UIImage(named: "testCoin")
       // image = UIImage.gifImageWithName("funny")
       // image = UIImage.gifImageWithName("single-coin-going")
      //  image = UIImage.gifImageWithName("Giff")

        kUserCoinImg = UIImageView()
        kUserCoinImg.image = image
        self.view.addSubview(kUserCoinImg)
        kUserCoinImg.hidden = false
        kUserCoinImg.frame = CGRectMake(viewWidth/2-50, userContainerView.frame.origin.y-75, kOneFifthWidth+25, 50+25)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        kUserCoinImg.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
        UIView.commitAnimations()

        timer = NSTimer(timeInterval: 1.2, target: self, selector: #selector(ViewController.hiddenZoomInObject), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        
        timer1 = NSTimer(timeInterval: 0.6, target: self, selector: #selector(ViewController.hiddenZoomInObjectaddCenterCoin), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(timer1, forMode: NSRunLoopCommonModes)
       
    }
    
    func hiddenZoomInObject(){
    
        for element in zoomIndataContainer {
            
            element.removeFromSuperview()
            kFirstUserCoinImg.hidden = true
            kUserCoinImg.hidden = true
        }
        zoomIndataContainer.removeAllObjects()
        
    }
    func hiddenZoomInObjectaddCenterCoin(){
    
        kCollectCoinImg.image = nil
        kCollectCoinImg.removeFromSuperview()
        kCollectCoinImg = UIImageView()
        image = UIImage.gifImageWithName("test-19")
        kCollectCoinImg.image = image
        kCollectCoinImg.frame = CGRectMake(viewWidth/2-60, viewHeight/2-60, 120, 120)
        self.view.addSubview(kCollectCoinImg)
        collectCoinTimerZoomIn = NSTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.collecitonCoinhidden), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(collectCoinTimerZoomIn, forMode: NSRunLoopCommonModes)
        
    }
    func collecitonCoinhidden() -> Void{
        
        isRepeteZoomIn = 0
        kCollectCoinImg.image = nil
        kCollectCoinImg.removeFromSuperview()
    }
    
    func playSound() {
        
        
        let audioFilePath = NSBundle.mainBundle().pathForResource("drum01", ofType: "mp3")
        if audioFilePath != nil {
            
            let audioFileUrl = NSURL.fileURLWithPath(audioFilePath!)
            audioPlayer = try? AVAudioPlayer(contentsOfURL: audioFileUrl)
            audioPlayer.play()
            
        } else {
            
            print("audio file is not found")
        }

    }
  
    func zoomOutBtnTapped() -> Void{
        
       playSound()
        
        if isRepeteZoomOut == 0 {
          
            isRepeteZoomOut = 1
            collectCoinTimerZoomOut = NSTimer(timeInterval: 0.0, target: self, selector: #selector(ViewController.collecitonCoinhiddenZoomOut), userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(collectCoinTimerZoomOut, forMode: NSRunLoopCommonModes)
        }
        
   
        
       // addPushAnimationZoomOut(true, aView: kUserCoinImg)

    }
    
    
    /// *****************************
    
        // ZOOM OUT //
    
    //*******************************
    
    
    func collecitonCoinhiddenZoomOut() -> Void{
        
        if kCollectCoinImg.image == nil {
            
            kCollectCoinImg = UIImageView()
            image = UIImage.gifImageWithName("Test-20")
            kCollectCoinImg.image = image
            kCollectCoinImg.frame = CGRectMake(viewWidth/2-60, viewHeight/2-60, 120, 120)
            self.view.addSubview(kCollectCoinImg)
            //collectCoinTimerZoomoutComplete
            
            collectCoinTimerZoomouthiddenCenter = NSTimer(timeInterval: 2.0, target: self, selector: #selector(ViewController.collectCoinTimerZoomoutCenterHidden), userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(collectCoinTimerZoomouthiddenCenter, forMode: NSRunLoopCommonModes)
            
            collectCoinTimerZoomoutComplete = NSTimer(timeInterval: 1.2, target: self, selector: #selector(ViewController.collectCoinTimerZoomoutAnimationStart), userInfo: nil, repeats: false)
            NSRunLoop.currentRunLoop().addTimer(collectCoinTimerZoomoutComplete, forMode: NSRunLoopCommonModes)

        }
        
        
        
    }
    func collectCoinTimerZoomoutCenterHidden() -> Void{
        
        kCollectCoinImg.image = nil
        kCollectCoinImg.removeFromSuperview()
        // addPushAnimationZoomOut(true, aView: kUserCoinImg)
        
    }
    
    func collectCoinTimerZoomoutAnimationStart() -> Void {
       
        addPushAnimationZoomOut(true, aView: kUserCoinImg)

    }
    
    func addPushAnimationZoomOut(directionBool: Bool, aView: UIView) -> Void{
       /*
        let animation = CATransition()
        animation.duration = 1.5
        animation.delegate = self
        animation.type = kCATransitionPush
        if directionBool == true{
            animation.subtype = kCATransitionFromTop
        }
        else{
            animation.subtype = kCATransitionFromLeft
        }
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeRemoved
        aView.layer.addAnimation(animation, forKey: "SwitchToView")
        
        kFirstUserCoinImg.hidden = false
        
        var x:Int = 0
        print(dataContainer)
        for contact in dataContainer{
            
            print(contact)
            var kDict   =   NSMutableDictionary()
            kDict = contact as! NSMutableDictionary
            print(kDict)
            let isCheck : Bool  = (kDict.objectForKey("isActive")?.boolValue)!
            if isCheck == false {
                x += 1
                print(x)
            }
            else{
                
                image = UIImage(named: "testCoin")
                // image = UIImage.gifImageWithName("single-coin-going")
                tempImge = UIImageView()
                tempImge.image = image
                zoomOutdataContainer.addObject(tempImge)
                self.view.addSubview(tempImge)
                
                let val : NSValue = xPossionContainer.objectAtIndex(x) as! NSValue
                print(x)
                print(val)
                let point: CGPoint = val.CGPointValue()
                x += 1
//                tempImge.frame = CGRectMake(point.x-10, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
//                tempImge.alpha = 1.0
                
                tempImge.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(1.5)
                tempImge.frame = CGRectMake(point.x-10, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
                UIView.commitAnimations()
            
            }
            
        }
        image = UIImage(named: "testCoin")
        //image = UIImage.gifImageWithName("single-coin-going")
        tempUserImage = UIImageView()
        tempUserImage.image = image
        self.view.addSubview(tempUserImage)
        tempUserImage.hidden = false
        tempUserImage.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        tempUserImage.frame = CGRectMake(viewWidth/2-36, userContainerView.frame.origin.y-36, kOneFifthWidth+25, 75)
        UIView.commitAnimations()
        
        tempTimer = NSTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.hiddenZoomOutObject), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(tempTimer, forMode: NSRunLoopCommonModes)
        */
     
        
        let animation = CATransition()
        animation.duration = 1.5
        animation.delegate = self
        animation.type = kCATransitionPush
        if directionBool == true{
            animation.subtype = kCATransitionFromTop
        }
        else{
            animation.subtype = kCATransitionFromLeft
            
        }
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeRemoved
        aView.layer.addAnimation(animation, forKey: "SwitchToView")
        
        kFirstUserCoinImg.hidden = false
        
        var x:Int = 0
        print(dataContainer)
        for contact in dataContainer{
            
            print(contact)
            var kDict   =   NSMutableDictionary()
            kDict = contact as! NSMutableDictionary
            print(kDict)
            let isCheck : Bool  = (kDict.objectForKey("isActive")?.boolValue)!
            if isCheck == false {
                x += 1
                print(x)
            }
            else{
                
                //Single-chip-going
                
                image = UIImage(named: "testCoin")
               // image = UIImage.gifImageWithName("single-coin-going")
                
                tempImge = UIImageView()
                tempImge.image = image
                zoomOutdataContainer.addObject(tempImge)
                self.view.addSubview(tempImge)
                tempImge.hidden = false

               
                self.label = UILabel()
                self.label.text = "100"
                self.label.textColor = UIColor.redColor()
               // self.view.addSubview(self.label)
                
                
               // winnerImageView.hidden = false
                winnerImage = UIImage.gifImageWithName("Test-1")
                winnerImageView = UIImageView()
                winnerImageView.image = winnerImage
             //   self.view.addSubview(winnerImageView)

                
                let val : NSValue = xPossionContainer.objectAtIndex(x) as! NSValue
                print(x)
                print(val)
                let point: CGPoint = val.CGPointValue()
                tempImge.frame = CGRectMake(point.x-10, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
                tempImge.alpha = 1.0

                if x == 1 {
                 
                    winnerImageView.frame = CGRectMake(point.x-20, _collectionView.frame.origin.y-20, kOneFifthWidth+35, 85)

                    tempImge.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
                    self.label.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y+20)
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(0.5)
                    tempImge.frame = CGRectMake(point.x-10, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
                    self.label.frame = CGRectMake(point.x, _collectionView.frame.origin.y+20, kOneFifthWidth+25, 75)
                    UIView.commitAnimations()
                }
                else if x == 3{
                
                    winnerImageView.frame = CGRectMake(point.x-20, _collectionView.frame.origin.y-20, kOneFifthWidth+35, 85)

                    tempImge.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
                    self.label.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y+20)
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(1.0)
                    tempImge.frame = CGRectMake(point.x-10, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
                    self.label.frame = CGRectMake(point.x, _collectionView.frame.origin.y+20, kOneFifthWidth+25, 75)
                    UIView.commitAnimations()
                }
                else if x == 4{
                
                    winnerImageView.frame = CGRectMake(point.x-20, _collectionView.frame.origin.y-20, kOneFifthWidth+35, 85)

                    tempImge.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
                    self.label.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y+20)
                    UIView.beginAnimations(nil, context: nil)
                    UIView.setAnimationDuration(1.5)
                    tempImge.frame = CGRectMake(point.x-10, _collectionView.frame.origin.y+25, kOneFifthWidth+25, 75)
                    self.label.frame = CGRectMake(point.x, _collectionView.frame.origin.y+20, kOneFifthWidth+25, 75)
                    UIView.commitAnimations()
                }
                else{
                
                }
                x += 1
               
            }
            
        }
      
        winnerImage = UIImage.gifImageWithName("Test-1")
        tempWinnerImageView = UIImageView()
        tempWinnerImageView.image = winnerImage
     //   self.view.addSubview(tempWinnerImageView)
        tempWinnerImageView.frame = CGRectMake(viewWidth/2-45, userContainerView.frame.origin.y-20, kOneFifthWidth+35, 85)

        
        image = UIImage(named: "testCoin")
        //image = UIImage.gifImageWithName("single-coin-going")
        tempUserImage = UIImageView()
        tempUserImage.image = image
        self.view.addSubview(tempUserImage)
        tempUserImage.hidden = false
        tempUserImage.center = CGPointMake(kViewCenterCoordinates!.x,kViewCenterCoordinates!.y)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.5)
        tempUserImage.alpha = 1.0
        tempUserImage.frame = CGRectMake(viewWidth/2-36, userContainerView.frame.origin.y-36, kOneFifthWidth+25, 75)
        UIView.commitAnimations()
        
        tempTimer = NSTimer(timeInterval: 1.5, target: self, selector: #selector(ViewController.hiddenZoomOutObject), userInfo: nil, repeats: false)
        NSRunLoop.currentRunLoop().addTimer(tempTimer, forMode: NSRunLoopCommonModes)
        
      
        /*
        let testwhiteBox = UIImageView()
        testwhiteBox.frame = CGRect(x: 30.0, y: _collectionView.frame.size.height+_collectionView.frame.origin.y, width: viewWidth, height: 150.0)
        var image1: UIImage?

        image1 = UIImage(named: "Box-1")

        testwhiteBox.image = image1
        self.view.addSubview(testwhiteBox)
        */

    }
    func hiddenZoomOutObject(){
        
        for element in zoomOutdataContainer {
            
            element.removeFromSuperview()
            tempImge.hidden = true
        }
        tempUserImage.hidden = true
        tempUserImage.hidden = true
        tempWinnerImageView.hidden = true
        winnerImageView.hidden = true
        zoomOutdataContainer.removeAllObjects()
        isRepeteZoomOut = 0
    }
    

    
}

