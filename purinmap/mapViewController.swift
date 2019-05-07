import UIKit
//MapKitのインポート
import MapKit
//現在地取得のためのインポート
import CoreLocation


class mapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    var regionNumber2: String?
    //LocationManagerの取得
    let myLocationManager = CLLocationManager()

    let myMapView = MKMapView()
    
    let userDefaults = UserDefaults.standard
    
    @IBAction func returnView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
  //MapViewを生成し、表示する
        myMapView.frame = self.view.frame
        self.view.addSubview(myMapView)
        
       
        //開いた時に保存されているピンを出したい
        
//        let getpin = userDefaults.array(forKey: "pinLocation") as! CLLocation?
//        let pin = MKPointAnnotation()
//
//        var getPinPoint = getpin?.coordinate

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
        //配列から現在座標を取得（配列lovationsの中から最新のものを取得する）
        let myLocation = locations.last! as CLLocation
        //pinに表示するためにはCLLocationCoordinate2Dに変換してあげる必要がある
        let currentLocation = myLocation.coordinate
        //ピンの生成と配置
        let pin = MKPointAnnotation()
        
        
        //アプリ起動時の表示領域の設定→最初のページで書かれた位置情報の場所に飛びたい
        let mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var myRegion = MKCoordinateRegion(center: currentLocation, span: mySpan)
        
        let number: String = regionNumber2!
        
        if number == "現在地" {
            
            //現在地を中心に地図を開く
            myMapView.region = myRegion
            
            pin.coordinate = currentLocation
            pin.title = "現在地"
            
            //ピンを表示
            self.myMapView.addAnnotation(pin)
            
        } else if number == "渋谷" {
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

        } else if number == "横浜" {
            
            //横浜駅中心で地図を表示
            let yokohamaPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.46578, 139.622313)
            
            myRegion = MKCoordinateRegion(center: yokohamaPoint, span: mySpan)
            
            myMapView.region = myRegion
            pin.coordinate = yokohamaPoint
            pin.title = "横浜駅"
            
            //ピンを表示
            self.myMapView.addAnnotation(pin)
            
        } else if number == "原宿" {
            
            //原宿駅中心で地図を表示
            
            let harajukuPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.670229, 139.702698)
            
            myRegion = MKCoordinateRegion(center: harajukuPoint, span: mySpan)
            
            
            myMapView.region = myRegion
            pin.coordinate = harajukuPoint
            pin.title = "原宿駅"
            
            //ピンを表示
            self.myMapView.addAnnotation(pin)
        }
    }
    
    
    //現在地の取得に失敗した場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("現在地の取得に失敗しました")
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
//
//        userDefaults.set(tappedLocation, forKey: "pinLocation")
        
        
        
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
        
        //ストーリーボードの名前を指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //viewにつけた名前を設定
        let vc = storyboard.instantiateViewController(withIdentifier: "library")
        //popoverを設定する
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        
        //間違っているかも？
        present(vc, animated: true, completion: nil)
        
        let popoverPresentationController = vc.popoverPresentationController
        popoverPresentationController?.sourceView = view
        popoverPresentationController?.sourceRect = view.bounds
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
