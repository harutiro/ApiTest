//
//  ViewController.swift
//  ApiTest
//
//  Created by Owner on 2021/12/28.
//

import UIKit

class ViewController: UIViewController {
    
    struct RecebedMain: Codable{
        let status:String
        let mode:String
        let data:[String]
    }
    
    struct RecebedData: Codable{
        let name:String
        let num:Double
    }
    
    var data: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let str :String = "Minecraft".urlEncoded
        let jsonUrlString = String("http://127.0.0.1:5000/near?str=\(str)")
        
        guard let url = URL(string: jsonUrlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do{
                let str = String(data: data, encoding: .utf8)!
                print(str)
                
                let myblog = try JSONDecoder().decode(RecebedMain.self, from: data)
                print(myblog.status)
                print(myblog.mode)
                print(myblog.data)
            } catch let jsonError{
                print("error", jsonError)
            }
        }.resume()
        
    }
    
}

extension String {
    
    var urlEncoded: String {
        // 半角英数字 + "/?-._~" のキャラクタセットを定義
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        // 一度すべてのパーセントエンコードを除去(URLデコード)
        let removed = removingPercentEncoding ?? self
        // あらためてパーセントエンコードして返す
        return removed.addingPercentEncoding(withAllowedCharacters: charset) ?? removed
    }
}

