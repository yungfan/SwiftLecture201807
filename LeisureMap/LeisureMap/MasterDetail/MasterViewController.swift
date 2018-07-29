//
//  MasterViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class MasterViewController: UIViewController {
    
    
    var categories: [ServiceCategory] = [] //Service数组
    
    var stores: [Store] = []  //Store数组
    
    var displayStores: [Store] = [] //展示的Store数组
    
    var selectedStore:Store? //选中的Store
    
    var selectedCategory:ServiceCategory? //选中的Category
    
    var fileWorker:FileWorker? //文件工具类
    
    let storeFileName:String = "store.json" //存储到沙盒的StoreJSON的文件名

    @IBOutlet weak var storeTableView: UITableView!
    
    @IBOutlet weak var serveceCollectionView: UICollectionView!
    
    
    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "Master"
        
        self.storeTableView.rowHeight = 80.0
        
        self.storeTableView.tableFooterView = UIView()
        
        self.getStores()
       
        self.getCategoryService()
        
        
        //设置横向间距
        (self.serveceCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumInteritemSpacing = 20
        
        //设置纵向间距-行间距
        (self.serveceCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing = 10
    }
    
    //MARK: - Actions
    //退出登录
    @IBAction func logout(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - 读取沙盒中的store.json并转成数组
    fileprivate func getStores(){
    
        //创建工具类
        self.fileWorker = FileWorker()
        
        let content = self.fileWorker?.readFromFile(fileName: storeFileName, tag: 4)
        
        do{
        
            if let dataFromString = content?.data(using: .utf8, allowLossyConversion: false) {

                let json = try JSON(data: dataFromString)

                for (_, subJSON) : (String, JSON) in json {

                    let serviceIndex :Int = subJSON["serviceIndex"].intValue
                    let name :String = subJSON["name"].stringValue
                    let location :JSON = subJSON["location"]
                    let imagePath :String = subJSON["imagePath"].stringValue
                    let index :Int = subJSON["index"].intValue

                    let address :String = location["address"].stringValue
                    let latitude :Double = location["latitude"].doubleValue
                    let longitude :Double = location["longitude"].doubleValue

                    let l = LocationDesc(address: address, latitude: latitude, longitude: longitude)

                    let s = Store(serviceIndex: serviceIndex, name: name, location: l, imagePath: imagePath, index: index)
                    
                    self.stores.append(s)

                }
            }
            
            //默认显示索引为0的那组数据
            self.displayStores = self.stores.filter({ (store:Store) -> Bool in
                
                return store.ServiceIndex == 0
                
            })

        }

        catch{

            print("\(error)")
        }
    
    }
    
    
    //MARK: - 从数据库中servicecategory表的数据并转成数组
    fileprivate func getCategoryService(){
        
        //初始化数据库工具类并完成创表等动作
        let sqliteWorker = SQLiteWorker()
        
        self.categories = sqliteWorker.readData()
        
        //重新加载UICollectionView
        self.serveceCollectionView.reloadData()
    }

}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension MasterViewController: UITableViewDataSource, UITableViewDelegate{
    
    //UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.displayStores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let storeCellView = tableView.dequeueReusableCell(withIdentifier: "StoreCellView", for: indexPath) as! StoreCellView
        
        storeCellView.updateContent(store: self.displayStores[indexPath.row])
        
        return storeCellView
    }
    
    //UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.selectedStore = self.displayStores[indexPath.row]
        
        self.performSegue(withIdentifier: "moveToDetailViewSegue", sender: self)
        
       
        
    }
    
}


//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MasterViewController: UICollectionViewDataSource, UICollectionViewDelegate{
   
    
    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.categories.count
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let serviceCellView = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCellView", for: indexPath) as! ServiceCellView
        
        serviceCellView.updateContent(service: self.categories[indexPath.row])
        
        return serviceCellView
        
    }


    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        self.selectedCategory = self.categories[indexPath.row]
        
        self.displayStores = self.stores.filter({ (store:Store) -> Bool in
            
            //左边的0-5  右边Index从1-6
            return store.ServiceIndex == self.selectedCategory!.Index
            
        })
        
        
        self.storeTableView.reloadData()
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        //通过segue的identifier判断到底是跳转的哪根线
        switch segue.identifier {
            
            case "moveToDetailViewSegue":
                
                let detailViewController = segue.destination as! DetailViewController
                
                detailViewController.selectedStore = self.selectedStore

            default:
   
                print("error")
        }
       
    }
    

}
