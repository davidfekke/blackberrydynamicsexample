//
//  supersecureappGDiOSDelegate.swift
//  supersecureapp
//
//  Created by David Fekke on 3/6/19.
//  Copyright © 2019 David Fekke. All rights reserved.
//

import Foundation
import UIKit
import GD.Runtime

class supersecureappGDiOSDelegate : NSObject , GDiOSDelegate {

    static let sharedInstance = supersecureappGDiOSDelegate()
    weak var appDelegate: AppDelegate? {
        didSet {
            didAuthorize()
        }
    }
    weak var rootViewController: UIViewController?{
        didSet {
            didAuthorize()
        }
    }
                                
    var hasAuthorized:Bool = false
                            
    
    func didAuthorize() -> Void {

                            if (hasAuthorized && (rootViewController != nil) && (appDelegate != nil) ) {
                            self.appDelegate!.didAuthorize()
                            }							
                        
    }
                            

// MARK: - BlackBerry Dynamics SDK Delegate Methods

    func handle(_ anEvent: GDAppEvent) {
     
    switch anEvent.type {
            case .authorized:
                onAuthorized(anEvent: anEvent)
                break;
               
            case .notAuthorized:
                self.onNotAuthorized(anEvent: anEvent)
                break;
                
            case .remoteSettingsUpdate:
                //A change to application-related configuration or policy settings.
                break;
                
            case .servicesUpdate:
                //A change to services-related configuration.
                break;
                  
             case .policyUpdate:
                //A change to one or more application-specific policy settings has been received.
                break;
                  
            default:
                print("handleEvent \(anEvent.message)")
            }
    }

    
    func onNotAuthorized(anEvent:GDAppEvent ) {
    /* Handle the BlackBerry Dynamics SDK not authorized event. */
        switch anEvent.code {
            case .errorActivationFailed: break
            case .errorProvisioningFailed: break
            case .errorPushConnectionTimeout: break
            case .errorSecurityError: break
            case .errorAppDenied: break
            case .errorAppVersionNotEntitled: break
            case .errorBlocked: break
            case .errorWiped: break
            case .errorRemoteLockout: break
            case .errorPasswordChangeRequired:
                // an condition has occured denying authorization, an application may wish to log these events
                print("onNotAuthorized \(anEvent.message)")
            case .errorIdleLockout:
                // idle lockout is benign & informational
                break

            default: assert(false, "Unhandled not authorized event");
        }
    }

    
    func onAuthorized(anEvent:GDAppEvent ) {
    /* Handle the BlackBerry Dynamics SDK authorized event. */
        switch anEvent.code {
            case .errorNone:
                if (!hasAuthorized) {
                    // Prepare main storyboard and root view controller
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = mainStoryboard.instantiateInitialViewController()
                    self.rootViewController = rootViewController;
                
                    self.appDelegate!.window?.rootViewController = rootViewController
                    hasAuthorized = true
                    didAuthorize()
                }
            default:
                assert(false, "Authorized startup with an error")
                break
        }
    }

}
                            
