//
//  ShopEntity.swift
//  ShopY
//
//  Created by Jae hyung Kim on 5/23/24.
//

import Foundation

struct ShopEntityMapper {
    
    func toEntity(_ dto: ShopItemDTOModel) -> ShopEntityModel? {
        
        let entity = ShopEntityModel(
            productId: dto.productId,
            title: dto.title.rmHTMLBold,
            link: dto.link,
            image: dto.image,
            lprice: NumberManager.shared.getTextToMoney(text: dto.lprice),
            hprice: dto.hprice,
            mallName: mallNameProcess(name: dto.mallName)
        )
        
        return entity
    }
}

extension ShopEntityMapper {
    
    func toEntity(_ dtos: [ShopItemDTOModel]) -> [ShopEntityModel] {
        
        return dtos.compactMap { toEntity($0) }
    }
    
    func toEntity(dtoP: ShopDTOModlel) -> (total: Int, [ShopEntityModel]) {
        
        return (dtoP.total, dtoP.items.compactMap({ toEntity($0) }))
    }
}

extension ShopEntityMapper {
    
    private
    func mallNameProcess(name: String) -> String {
        return name + " 판매자"
    }
}