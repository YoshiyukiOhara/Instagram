//
//  CommentViewController.swift
//  Instagram
//
//  Created by Yoshi on 2018/10/20.
//  Copyright © 2018年 yoshiyuki.oohara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class CommentViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    var postData: PostData!
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any) {
        if textField.text != "" {
            // postDataに必要な情報を取得しておく
            let name = Auth.auth().currentUser?.displayName
            let comment = textField.text!
            
            // Firebaseに保存するデータの準備
            postData.comments.append("\(name!) : \(comment)")
            print("DEBUG_PRINT: \(name!) : \(comment)")
           
            // 増えたcommentsをFirebaseに保存する
            let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
            let comments = ["comments": postData.comments]
            postRef.updateChildValues(comments)
            print("DEBUG_PRINT: \(comments)")
            
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "投稿しました")
            
            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        } else {
            // HUDで投稿失敗を表示する
            SVProgressHUD.showError(withStatus: "コメントを入力して下さい")
        }
    }
    
    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
