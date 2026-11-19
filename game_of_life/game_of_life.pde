// GAME OF LIFE =================================

//Screen config
int PIXEL_SCALE = 4;

//Simulation config
float INIT_DEAD_PERCENT = 0.9;

// ==============================================

int[] frame;
int[] prevFrame;
PImage texture;
int w, h;

color white = color(255, 255, 255);
color black =  color(0, 0, 0);

void setup() {
    fullScreen();
    noSmooth();
    
    //initialize screen texture
    texture = createImage(width / PIXEL_SCALE, height / PIXEL_SCALE, RGB);
    w = texture.width;
    h = texture.height;
    loadPixels();
    
    //Initialize arrays
    frame = new int[texture.pixels.length];
    prevFrame = new int[texture.pixels.length];
    
    for(int i = 0; i < texture.pixels.length; i++){    
        float rand =  random(0, 1);
    
        if(rand > INIT_DEAD_PERCENT)
        {
            prevFrame[i] = 1;
            frame[i] = 1;
        }
        else
        {      
            prevFrame[i] = 0;
            frame[i] = 0;
        }
    }
}

void applyRules(int px, int py)
{
    //Count number of neighbours
    int neighbourCount = 0;
    for(int nx = -1; nx <= 1; nx++)
    {
        for(int ny = -1; ny <= 1; ny++)
        {
            //Ignore the same pixel
            if(nx == 0 && ny == 0) {
                continue;
            }

            int x = (((px + nx) % w) + w) % w;  
            int y = (((py + ny) % h) + h) % h;
            int i = y * w + x;
            
            if(prevFrame[i] == 1) {
                neighbourCount++;
            }
        }
    }
    
    int i = py * w + px;

    // Default
    if (prevFrame[i] == 1) { frame[i] = (neighbourCount < 2 || neighbourCount > 3) ? 0 : 1; } 
    else { frame[i] = (neighbourCount == 3) ? 1 : 0; }

    // HighLife
    // if (prevFrame[i] == 1) { frame[i] = (neighbourCount < 2 || neighbourCount > 3) ? 0 : 1; }
    // else { frame[i] = (neighbourCount == 3 || neighbourCount == 6) ? 1 : 0; }

    // Flock
    // if (prevFrame[i] == 1) { if (neighbourCount == 1 || neighbourCount == 2) { frame[i] = 1; } if (neighbourCount == 0 || (neighbourCount <= 3 && neighbourCount >= 8)) { frame[i] = 0; }} 
    //else { if (neighbourCount == 3) { frame[i] = 1; }}

    // Seeds
    // if (prevFrame[i] == 1) { frame[i] = 0; } 
    // else { frame[i] = (neighbourCount == 2) ? 1 : 0; }
}

void draw()
{    
    //Draw pixels
    texture.loadPixels();
    for(int i = 0; i < texture.pixels.length; i++)
    {
        texture.pixels[i] = frame[i] == 0 ? black : white; 
    }

    texture.updatePixels();
    image(texture, 0, 0, width, height);

    //Apply rules
    for(int x = 0; x < w; x++)
    {
        for(int y = 0; y < h; y++)
        {
            applyRules(x, y);
        }
    }

    int[] tmp = frame;
    frame = prevFrame;
    prevFrame = tmp;
}