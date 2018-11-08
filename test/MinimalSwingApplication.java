import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JOptionPane;

public final class MinimalSwingApplication {
  
  public static void main(String... aArgs){
    MinimalSwingApplication app = new MinimalSwingApplication();
    app.buildAndDisplayGui();
  }

  private void buildAndDisplayGui(){
    JFrame frame = new JFrame("Test Frame"); 
    buildContent(frame);
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.pack();
    frame.setVisible(true);
  }
  
  private void buildContent(JFrame aFrame){
    JPanel panel = new JPanel();
    panel.add(new JLabel("Hello"));
    JButton ok  = new JButton("OK");
    JButton exit = new JButton("Exit");
    ok.addActionListener(new ShowDialog(aFrame));
    panel.add(ok);
    exit.addActionListener(new CloseListener());
    panel.add(exit);
    aFrame.getContentPane().add(panel);      
  }
   
   private static final class CloseListener implements ActionListener{
      public void actionPerformed(ActionEvent e) {
         System.exit(0);
      }
   }
   
   private static final class ShowDialog implements ActionListener {
      ShowDialog(JFrame aFrame){
         fFrame = aFrame;
      }
      @Override public void actionPerformed(ActionEvent aEvent) {
         JOptionPane.showMessageDialog(fFrame,
                                       "This is a dialog",
                                       "Dialup",
                                       JOptionPane.INFORMATION_MESSAGE);
      }
      private JFrame fFrame;
   }
}
