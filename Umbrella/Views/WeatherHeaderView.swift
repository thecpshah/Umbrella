//
//  WeatherHeaderView.swift
//  Umbrella
//
//  Created by Elliott Minns on 09/07/2016.
//  Copyright © 2016 Elliott Minns. All rights reserved.
//

import UIKit

class WeatherHeaderView: UIView {
    
    let locationLabel: UILabel
    
    let temperatureLabel: UILabel
    
    let descriptionLabel: UILabel
    
    let forecast: Forecast
    
    init(forecast: Forecast) {
        self.forecast = forecast
        locationLabel = UILabel()
        temperatureLabel = UILabel()
        descriptionLabel = UILabel()
        super.init(frame: CGRectZero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        backgroundColor = Defaults.Color.Blue.base
        setupViews()
    }
    
    func setupViews() {
        setupLocationLabel()
        setupDescriptionLabel()
        setupTemperatureLabel()
    }
    
    func loadLabel(label: UILabel, withFontSize size: Defaults.Fonts = .Normal) {
        label.textColor = Defaults.Color.White.base
        label.textAlignment = .Center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = size.font
        addSubview(label)
    }
    
    func setupLocationLabel() {
        locationLabel.text = forecast.placeName
        loadLabel(locationLabel, withFontSize: .Header)
        let constraints = loadLabelConstraints(forLabel: locationLabel,
                                               withTopView: self)
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
    func loadLabelConstraints(forLabel label: UILabel,
                                       withTopView view: UIView) -> [NSLayoutConstraint] {
        let constraints: [NSLayoutConstraint]
        
        if #available(iOS 9.0, *) {
            
            let topAnchor: NSLayoutAnchor
            if view == self {
                topAnchor = self.topAnchor
            } else {
                topAnchor = view.bottomAnchor
            }
            
            constraints = [
                label.topAnchor.constraintEqualToAnchor(topAnchor),
                label.heightAnchor.constraintEqualToAnchor(heightAnchor,
                    multiplier: 0.32),
                label.leftAnchor.constraintEqualToAnchor(leftAnchor),
                label.rightAnchor.constraintEqualToAnchor(rightAnchor)
            ]
        } else {
            constraints = []
        }
        
        return constraints
    }
    
    func setupTemperatureLabel() {
        loadLabel(temperatureLabel, withFontSize: .Header)
        temperatureLabel.text = forecast.currentTemperature(inUnit: .Celsius)?.description
        
        let constraints = loadLabelConstraints(forLabel: temperatureLabel,
                                               withTopView: descriptionLabel)
        NSLayoutConstraint.activateConstraints(constraints)
        
    }
    
    func setupDescriptionLabel() {
        loadLabel(descriptionLabel, withFontSize: .Large)
        descriptionLabel.text = forecast.weather.first?.description.capitalizedString
        let constraints = loadLabelConstraints(forLabel: descriptionLabel,
                                               withTopView: locationLabel)
        NSLayoutConstraint.activateConstraints(constraints)
    }
    
}