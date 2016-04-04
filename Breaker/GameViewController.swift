

import UIKit
import SceneKit

class GameViewController: UIViewController {
  
  var scnView: SCNView!
  var scnScene: SCNScene!
  var game = GameHelper.sharedInstance
  var horizontalCameraNode: SCNNode!
  var verticalCameraNode: SCNNode!
  var ballNode: SCNNode!
  var paddleNode: SCNNode!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupScene()
    setupNodes()
    setupSounds()
  }
  
  func setupScene() {
    scnView = self.view as! SCNView
    scnView.delegate = self
    
    scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
    scnView.scene = scnScene
  }
  
  func setupNodes() {
    horizontalCameraNode = scnScene.rootNode.childNodeWithName("HorizontalCamera", recursively: true)!
    verticalCameraNode = scnScene.rootNode.childNodeWithName("VerticalCamera", recursively: true)!
    
    scnScene.rootNode.addChildNode(game.hudNode)
    
    ballNode = scnScene.rootNode.childNodeWithName("Ball", recursively: true)!
    
    paddleNode = scnScene.rootNode.childNodeWithName("Paddle", recursively: true)!
  }
  
  func setupSounds() {
  }
  
  override func shouldAutorotate() -> Bool {
    return true
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  // 1
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    // 2
    let deviceOrientation = UIDevice.currentDevice().orientation
    switch(deviceOrientation) {
    case .Portrait:
      scnView.pointOfView = verticalCameraNode
    default:
      scnView.pointOfView = horizontalCameraNode
    }
  }
}

extension GameViewController: SCNSceneRendererDelegate {
  func renderer(renderer: SCNSceneRenderer, updateAtTime time: NSTimeInterval) {
    game.updateHUD()
  }
}
