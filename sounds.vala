using Gtk;
using Gdk;
using Gee;

namespace Sounds {
  class Window : Gtk.Window {
    private HashMap<uint, bool> pressed;
  
    public Window () {
      pressed = new HashMap<uint, bool>();
    
      this.set_default_size(1000, 1000);

      this.add_events(Gdk.EventMask.BUTTON_RELEASE_MASK);
      this.button_press_event.connect(on_button_press);
      this.button_release_event.connect(on_button_release);
      this.key_press_event.connect(on_key_press);
      this.key_release_event.connect(on_key_release);
    }
    
    private bool on_button_press(Gdk.EventButton event) {
      stdout.printf("button %u pressed\n", event.button);
      
      return true;
    }
  
  
    private bool on_button_release(Gdk.EventButton event) {
      stdout.printf("button %u released\n", event.button);
      
      return true;
    }
    
    private bool on_key_press(Gdk.EventKey event) {
      if (!pressed[event.keyval]) {
        pressed[event.keyval] = true;
        switch (event.keyval) {
        case Gdk.Key.Up:
          stdout.printf("up pressed\n");
          break;
        case Gdk.Key.Down:
          stdout.printf("down pressed\n");
          break;
        case Gdk.Key.Left:
          stdout.printf("left pressed\n");
          break;
        case Gdk.Key.Right:
          stdout.printf("right pressed\n");
          break;
        case Gdk.Key.w:
          stdout.printf("w pressed\n");
          break;
        case Gdk.Key.a:
          stdout.printf("a pressed\n");
          break;
        case Gdk.Key.s:
          stdout.printf("s pressed\n");
          break;
        case Gdk.Key.d:
          stdout.printf("d pressed\n");
          break;
        case Gdk.Key.f:
          stdout.printf("f pressed\n");
          break;
        case Gdk.Key.g:
          stdout.printf("g pressed\n");
          break;
        case Gdk.Key.space:
          stdout.printf("space pressed\n");
          break;
        default:
          stdout.printf("different key pressed\n");
          break;
        }
      }

      return true;
    }
    
    private bool on_key_release(Gdk.EventKey event) {
      pressed[event.keyval] = false;
      switch (event.keyval) {
      case Gdk.Key.Up:
        stdout.printf("up released\n");
        break;
      case Gdk.Key.Down:
        stdout.printf("down released\n");
        break;
      case Gdk.Key.Left:
        stdout.printf("left released\n");
        break;
      case Gdk.Key.Right:
        stdout.printf("right released\n");
        break;
      case Gdk.Key.w:
        stdout.printf("w released\n");
        break;
      case Gdk.Key.a:
        stdout.printf("a released\n");
        break;
      case Gdk.Key.s:
        stdout.printf("s released\n");
        break;
      case Gdk.Key.d:
        stdout.printf("d released\n");
        break;
      case Gdk.Key.f:
        stdout.printf("f released\n");
        break;
      case Gdk.Key.g:
        stdout.printf("g released\n");
        break;
      case Gdk.Key.space:
        stdout.printf("space released\n");
        break;
      default:
        stdout.printf("different key released\n");
        break;
      }
      
      return true;
    }

    public static int main (string[] args) {
      Gtk.init(ref args);

      var app = new Window();
      app.show_all();

      app.destroy.connect(Gtk.main_quit);

      Gtk.main ();
      return 0;
    }

  }
}
