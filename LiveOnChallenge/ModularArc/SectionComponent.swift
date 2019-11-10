//
//  SectionComponent.swift
//  LiveOnChallenge
//
//  Created by Pedro Albuquerque on 09/11/19.
//

import UIKit

class SectionComponent {
    var section = 0
    var title: String?
    var components = [UIView]()
    
    init(section: Int){
        self.section = section
    }
}

protocol SectionManager: class {
    var componentViews: [SectionComponent] {get set}
    var componentsTemp: [SectionComponent] {get set}
    func reloadData()
    func reloadComponent(sec: Int, index: Int)
    func insertCell(sec: Int, index: Int)
    func insertComponent(view: UIView, index: Int, section: Int)
    func addComponent(view: UIView, section: Int)
    func removeComponent(index: Int, section: Int)
    func removeCell(index: Int, section: Int)
    func clearComponents()
    func getSection(_ sec: Int) -> SectionComponent?
    func setSectionTitle(section: Int, title: String)
}

extension SectionManager {
    func insertComponent(view: UIView, index: Int, section: Int = 0){
        self.getSection(section).components.insert(view, at: index)
        self.insertCell(sec: section, index: index)
    }
    
    func addComponent(view: UIView, section: Int = 0){
        self.getSection(section).components.append(view)
        self.reloadData()
    }
    
    func removeComponent(index: Int, section: Int = 0){
        self.getSection(section).components.remove(at: index)
        self.removeCell(index: index, section: section)
    }
    
    func clearComponents(){
        self.componentViews.removeAll()
        self.reloadData()
    }
    
    func getSection(_ sec: Int) -> SectionComponent? {
        let section = self.componentViews.filter{$0.section == sec}.first
        return section
    }
    
    func showLoadingComponent(icon: UIImage = #imageLiteral(resourceName: "loading"), title: String = "Carregando...", desc: String = "Por favor, aguarde."){
        self.componentsTemp = self.componentViews
        self.clearComponents()
        self.addComponent(view: EmptyComponent(icon: icon, title: "Carregando...", description: "Por favor, aguarde."))
        
    }
    
    func endLoadingComponent(){
        self.clearComponents()
        self.componentViews = self.componentsTemp
        self.reloadData()
    }
    
    func showEmptyComponent(icon: UIImage = #imageLiteral(resourceName: "empty"), title: String = "Nenhum dado foi encontrado", desc: String = "Tente Novamente"){
        self.clearComponents()
        self.addComponent(view: EmptyComponent(icon: icon, title: title, description: desc))
    }
    
    private func getSection(_ sec: Int) -> SectionComponent {
        let section = self.componentViews.filter{$0.section == sec}.first
        if section == nil {
            let newSection = SectionComponent(section: sec)
            self.componentViews.append(newSection)
            return newSection
        }
        return section!
    }
    
    func setSectionTitle(section: Int, title: String) {
        self.getSection(section).title = title
        self.reloadData()
    }
}


