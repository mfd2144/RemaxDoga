//
//  EstateInformation.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 7.06.2022.
//

import SwiftUI

struct EstateInformation: View {
    // MARK: - Properties
    @Binding var type: RealEstateType?
    @Binding var condition: RealEstateCondition?
    @Binding var landType: LandType?
    @Binding var landCoefficient: LandCoefficient?
    @Binding var place: Places?
    @State private var show = false
    @State private var showCondition = false
    @State private var showLand = false
    @State private var showPlaces = false
    @State private var showCoefficient = false
    // MARK: - Functions
    private func addTextBox<T:Identifiable>(_ value: T?)->Text?{
        guard let value = value  else {
            return nil
        }
        if let place = value as? Places{
            return Text("\(changeString(value:(place.id as String)) ?? "")")
        }
        return Text("\((value.id as? String)!)")
    }
   
    
    var body: some View {
        GroupBox (content:{
            //Real Estate Type
            DisclosureGroup (isExpanded: $show ,content: {
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                    ForEach(RealEstateType.allCases){item in
                        Text(item.name).onTapGesture {
                            withAnimation {
                                self.show.toggle()
                                type = item
                            }
                        }
                    }
                })// End: -LazyVStack
                .padding(.top,10)
            }, label: {
                HStack {
                    Text("Emlak Türü")
                    Spacer()
                    addTextBox(type)
                }// End: -HStack
            })// End:- Disclosure Group
            Divider()
            if type == RealEstateType.land{
                //LandType
                DisclosureGroup (isExpanded: $showLand ,content: {
                    LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                        ForEach(LandType.allCases){item in
                            Text(item.name).onTapGesture {
                                withAnimation {
                                    self.showLand.toggle()
                                    landType = item
                                }
                            }
                        }
                    })// End: -LazyVStack
                    .padding(.top)
                }, label: {
                    HStack {
                        Text("Arsa Tipi")
                        Spacer()
                        addTextBox(landType)
                    }// End: -HStack
                })// End:- Disclosure Group
                Divider()
                //LandType
                DisclosureGroup (isExpanded: $showCoefficient ,content: {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                            ForEach(LandCoefficient.allCases){item in
                                Text(item.name).onTapGesture {
                                    withAnimation {
                                        self.showCoefficient.toggle()
                                        landCoefficient = item
                                    }
                                }
                            }
                        })// End: -LazyVStack
                        .padding(.top)
                    }// End: -ScrollView
                    .frame(height: 200)
                }, label: {
                    HStack {
                        Text("Emsal")
                        Spacer()
                        addTextBox(landCoefficient)
                    }// End: -HStack
                })// End:- Disclosure Group
                Divider()
            }
            //Real Estate Condition
            DisclosureGroup (isExpanded: $showPlaces ,content: {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                        ForEach(Places.allCases){item in
                            Text(changeString(value:item.name) ?? "").onTapGesture {
                                withAnimation {
                                    self.showPlaces.toggle()
                                    place = item
                                }
                            }
                        }
                    })// End: -LazyVStack
                    .padding(.top)
                }
                .frame(height: 200)
            }, label: {
                HStack {
                    Text("Yeri")
                    Spacer()
                    addTextBox(place)
                }// End: -HStack
            })// End:- Disclosure Group
            Divider()
            //Real Estate Condition
            DisclosureGroup (isExpanded: $showCondition ,content: {
                LazyVStack(alignment: .leading, spacing: 15, pinnedViews: [], content: {
                    ForEach(RealEstateCondition.allCases){item in
                        Text(item.name).onTapGesture {
                            withAnimation {
                                self.showCondition.toggle()
                                condition = item
                            }
                        }
                    }
                })// End: -LazyVStack
                .padding(.top)
            }, label: {
                HStack {
                    Text("Durumu")
                    Spacer()
                    addTextBox(condition)
                }// End: -HStack
            })// End:- Disclosure Group
        }, label: {
            GroupBoxLabelView(title: "Emlak Bilgileri", imageName: "building.columns.circle")
        })// End: -GroupBox
        .padding(.horizontal)
    }
}

struct EstateInformation_Previews: PreviewProvider {
    static var previews: some View {
        EstateInformation(type: .constant(nil), condition: .constant(nil), landType: .constant(nil), landCoefficient: .constant(nil), place: .constant(nil))
    }
}
