import UIKit
//MapKitのインポート
import MapKit
//現在地取得のためのインポート
import CoreLocation
import RealmSwift

class CustomAnnotation: MKPointAnnotation {
    var tag: Int?
}


class mapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    //新規保存用
    var version: Int = 0
    var tappedLatitude: Double!
    var tappedLongitude: Double!
    //保存されているのを表示して更新用
    var getShopName: String!
    var getComment: String!
    var getReview: String!
    var getReviewStar: String!
    var getLatitude: Double!
    var getLongitude: Double!
    var getImage: UIImage!
    var getId: Int!
    
    
    var regionNumber2: String?
    //LocationManagerの取得
    let myLocationManager = CLLocationManager()
    
    let myMapView = MKMapView()
    
    let userDefaults = UserDefaults.standard
    
    var myLocation: CLLocation! = nil
    
    @IBAction func returnView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    let realm = try!Realm()
    
    var puddingArray: Results<PuddingList>!
    
    
    //画面を開くたびに呼ばれるメソッド
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewWillAppear")
        
        puddingArray = realm.objects(PuddingList.self)
        
        if puddingArray != nil {
        
        //for文で配列番号を繰り返してその都度ピンを発生させる
            
            for i in 0..<puddingArray.count {
                
                let getPin = CustomAnnotation()
                let getTappedLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(puddingArray[i].shopLatitude, puddingArray[i].shopLongitude)
                getPin.coordinate = getTappedLocation
                getPin.title = puddingArray[i].shopName
                getPin.tag = i
                self.myMapView.addAnnotation(getPin)
            
           
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //MapViewを生成し、表示する
        myMapView.frame = self.view.frame
        self.view.addSubview(myMapView)
        
        
        //長押しを探知する機能を追加
        //ジェスチャーを生成
        let longPressGesture = UILongPressGestureRecognizer()
        //ボタンを押した時の処理
        longPressGesture.addTarget(self, action: #selector(longPressed(sender:)))
        myMapView.addGestureRecognizer(longPressGesture)
        
        //ここからが現在地取得の処理
        myLocationManager.delegate = self
        
        myMapView.delegate = self
        
        
        
        //セキュリティ認証のステータスを取得
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.notDetermined {
            //まだ認証が得られてない場合は、認証ダイアログを表示
            myLocationManager.requestAlwaysAuthorization()
        }
        
        //現在地取得の開始
        myLocationManager.startUpdatingLocation()
        print("現在地取得なう")
        
    }
    
    
    //現在地の取得に成功した場合の処理
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("現在地の取得に成功しました")
        
        if myLocation == nil {
            
        //配列から現在座標を取得（配列lovationsの中から最新のものを取得する）
        myLocation = locations.first! as CLLocation
            
        
        //pinに表示するためにはCLLocationCoordinate2Dに変換してあげる必要がある
        let currentLocation = myLocation.coordinate
        
        
        //ピンの生成と配置
        let pin = MKPointAnnotation()
        
        
        //アプリ起動時の表示領域の設定→最初のページで書かれた位置情報の場所に飛びたい
        let mySpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var myRegion = MKCoordinateRegion(center: currentLocation, span: mySpan)
        
        let number: String = regionNumber2!
        
        if number == "現在地" {
            
            //現在地を中心に地図を開く
            myMapView.region = myRegion
            
//            pin.coordinate = currentLocation
//            pin.title = "現在地"
//
//            //ピンを表示
//            self.myMapView.addAnnotation(pin)
//
        } else if number == "渋谷エリア" {
            //ここで表示する領域を場所ごとに変える、渋谷駅中心
            //渋谷駅の緯度、経度  中心点
            let shibuyaPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.658034, 139.701636)
            
            //表示領域
            myRegion = MKCoordinateRegion(center: shibuyaPoint, span: mySpan)
            
            //渋谷駅を中心にマップを開く
            myMapView.region = myRegion
            
            pin.coordinate = shibuyaPoint
            pin.title = "渋谷駅"
            
            //ピンを表示
            self.myMapView.addAnnotation(pin)
            
        } else if number == "横浜エリア" {
            
            //横浜駅中心で地図を表示
            let yokohamaPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.46578, 139.622313)
            
            myRegion = MKCoordinateRegion(center: yokohamaPoint, span: mySpan)
            
            myMapView.region = myRegion
            pin.coordinate = yokohamaPoint
            pin.title = "横浜駅周辺"
            
            //ピンを表示
            self.myMapView.addAnnotation(pin)
            
        } else if number == "吉祥寺エリア" {
            
            //原宿駅中心で地図を表示
            
            let kichiPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.702811, 139.579804),
            
            myRegion = MKCoordinateRegion(center: kichiPoint, span: mySpan)
            
            
            myMapView.region = myRegion
            pin.coordinate = kichiPoint
            pin.title = "吉祥寺駅"
            
            //ピンを表示
            self.myMapView.addAnnotation(pin)
        }
        
        }
        
       
    }
    
    
    //現在地の取得に失敗した場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("現在地の取得に失敗しました")
        //位置情報の取得許可をiPhone上で行う
        let alert = UIAlertController(
            title: "位置情報の取得失敗", message: "位置情報の利用を許可してください", preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil
            
        ))
    }
    
    
    //長押しした時にピンを置く処理
    @objc func longPressed(sender: UILongPressGestureRecognizer) {
        print("long pressed")
        
        //この処理を書くことにより、指を離した時だけ反応するようにする
        if sender.state != UIGestureRecognizer.State.began {
            return
        }
        
        
        //senderから長押しした地図上の座標を取得
        let tappedLocation = sender.location(in: myMapView)
        let tappedPoint = myMapView.convert(tappedLocation, toCoordinateFrom: myMapView)
        
        
        tappedLatitude = tappedPoint.latitude
        tappedLongitude = tappedPoint.longitude
        
        print("\(tappedLatitude!),\(tappedLongitude!)")
        
        
        print("long pressed")
        //ピンの生成
        let pin = MKPointAnnotation()
        //ピンを置き場所を指定
        pin.coordinate = tappedPoint
        //ピンのタイトルの設定
        pin.title = "タイトル"
        //ピンのサブタイトルの設定
        //        pin.subtitle = "サブタイトル"
        //ピンの画像の設定
        
        //ピンをMapViewの上に置く
        self.myMapView.addAnnotation(pin)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        //Identifier
        let myAnnotationIdentifier = "myAnnotation"
        
        //AnnotationViewをdequeue  dequeue はキューから要素を取り出す操作（デキュー）も表すため、技術的な文書では避けるのが一般的である。
        var myAnnotationView: MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: myAnnotationIdentifier)
        
        //アノテーションの右側につけるボタンの設定
        let button: UIButton = UIButton(type: UIButton.ButtonType.infoLight)
        
        if myAnnotationView == nil {
            myAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myAnnotationIdentifier)
            
            //アノテーションの右側にボタンをつける
            myAnnotationView.rightCalloutAccessoryView = button
            myAnnotationView.canShowCallout = true
        }
        return myAnnotationView
    }
    
    
    //ボタンを押された時
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        //アノテーションを消す
        if let annotation = view.annotation {
            mapView.deselectAnnotation(annotation, animated: true)
        }
        
        if let tag = (view.annotation as? CustomAnnotation)?.tag {
            getShopName = puddingArray[tag].shopName
            getComment = puddingArray[tag].commnet
            getReview = puddingArray[tag].review
            getReviewStar = puddingArray[tag].reviewStarRealm
            getLatitude = puddingArray[tag].shopLatitude
            getLongitude = puddingArray[tag].shopLongitude
            getImage = puddingArray[tag].purinImage
            getId = puddingArray[tag].id
            
            version = 1
            
        } else {
            getShopName = ""
            getComment = ""
            getReview = "0.0"
            getReviewStar = "☆ ☆ ☆ ☆ ☆"
            version = 0
            getImage = nil
        }
        
    
        
        //segueを使って画面遷移
        
        self.performSegue(withIdentifier: "toRegister", sender: nil)

        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegister" {
            
            let LibraryViewController: libraryViewController = segue.destination as! libraryViewController
            
            
            LibraryViewController.receiveShopName = self.getShopName
            LibraryViewController.receiveComment = self.getComment
            LibraryViewController.receiveReview = self.getReview
            LibraryViewController.receiveReviewStar = self.getReviewStar
            LibraryViewController.receiveVersion = self.version
            LibraryViewController.receiveImage = self.getImage
            LibraryViewController.receiveId = self.getId
            
            if version == 0 {
                //新規保存用
                LibraryViewController.newLatitude = self.tappedLatitude
                LibraryViewController.newLongitude = self.tappedLongitude
                
            } else {
                //既存のデータ更新用
                
                LibraryViewController.receiveLatitude = self.getLatitude
                LibraryViewController.receiveLongitude = self.getLongitude
            print("値の受け渡し完了")
            }
        }
    }
}
