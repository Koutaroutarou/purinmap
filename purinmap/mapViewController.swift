import UIKit
//MapKitのインポート
import MapKit
//現在地取得のためのインポート
import CoreLocation


class mapViewController: UIViewController, CLLocationManagerDelegate {
    
    //LocationManagerの取得
    let myLocationManager = CLLocationManager()
//    @IBOutlet var MapView: MKMapView!
    let myMapView = MKMapView()
    
    @IBAction func modoru() {
        self.dismiss(animated: true, completion: nil)
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
        pin.coordinate = currentLocation
        pin.title = "現在地"
        self.myMapView.addAnnotation(pin)
        //アプリ起動時の表示領域の設定→最初のページで書かれた位置情報の場所に飛びたい

        var mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        var myRegion = MKCoordinateRegion(center: currentLocation, span: mySpan)

        if ViewController().regionNumber == 0 {
            myMapView.region = myRegion
        } else if ViewController().regionNumber == 1 {
            //ここで表示する領域を場所ごとに変える
            mySpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            myRegion = MKCoordinateRegion(center: currentLocation, span: mySpan)

        }
    }
    
    
    //現在地の取得に失敗した場合の処理
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("現在地の取得に失敗しました")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        
        print("long pressed")
        //ピンの生成
        let pin = MKPointAnnotation()
        //ピンを置き場所を指定
        pin.coordinate = tappedPoint
        //ピンのタイトルの設定
        pin.title = "タイトル"
        //ピンのサブタイトルの設定
        pin.subtitle = "サブタイトル"
        //ピンの画像の設定
    
        //ピンをMapViewの上に置く
        self.myMapView.addAnnotation(pin)
        
    }

 

}
