//
//  UIImage+Extension.swift
//  Wanderer
//
//  Created by 刘杰 on 16/9/23.
//  Copyright © 2016年 even. All rights reserved.
//

import UIKit
extension UIImage {
    class func getImageWithColor(color : UIColor) ->UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        
        let ctx = UIGraphicsGetCurrentContext()
        
       CGContextSetFillColorWithColor(ctx, color.CGColor)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func getBottomImage(image : UIImage) ->UIImage? {
        let rect = CGRectMake(0, 0, kScreenWidth, 64)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        
        let path = UIBezierPath(rect: rect)
        
        path.addClip()
        image.drawAtPoint(CGPointMake(0, 64 - image.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    class func getMapPinViewWithNumber(number : Int, image : UIImage) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0)
        image.drawAtPoint(CGPointZero)
        
        let str = "\(number)" as NSString
        if number < 10 {
            str.drawInRect(CGRectMake(8, 10, 16, 16), withAttributes: [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.systemFontOfSize(10)])
        } else {
            str.drawInRect(CGRectMake(5, 10, 16, 16), withAttributes: [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont.systemFontOfSize(10)])
        }
        
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func getImageWithBorder(image : UIImage) -> UIImage {
        //0.加载图片
        //UIImage *image = [UIImage imageNamed:@"阿狸头像"];
        //1.确定边框宽度
        //CGFloat borderW = 5;
        //2.开启一个上下文
        let size = CGSizeMake(image.size.width + 10, image.size.width + 10)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        //3.绘制大圆,显示出来
        let path = UIBezierPath(ovalInRect: CGRectMake(0, 0, size.width, size.width))
        UIColor.whiteColor().set()
        path.fill()
        //4.绘制一个小圆,把小圆设置成裁剪区域
        let clipPath = UIBezierPath(ovalInRect: CGRectMake(5, 5, image.size.width, image.size.width))
        clipPath.addClip()
        //5.把图片绘制到上下文当中
        image.drawAtPoint(CGPointMake(5, 5));
        //6.从上下文当中取出图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        //7.关闭上下文
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    class func getFullScreenImage(view : UIView) ->UIImage {
        //把控制器的View生成一张图片
        
        //1.开启一个位图上下文(跟当前控制器View一样大小的尺寸)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kScreenHeight), false, 0);
        
        //把把控制器的View绘制到上下文当中.
        //2.想要把UIView上面的东西给绘制到上下文当中,必须得要使用渲染的方式.
        let ctx = UIGraphicsGetCurrentContext()
        
        view.layer.renderInContext(ctx!)
        //[self.view.layer drawInContext:ctx];
        
        //3.从上下文当中生成一张图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //4.关闭上下文
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
