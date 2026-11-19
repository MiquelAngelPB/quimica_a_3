// WOLFRAM =================================

//Screen config
int PIXEL_SCALE = 4;

//Simulation config
float INIT_DEAD_PERCENT = 0.9;

// Rule 30 - Caótico
// int[] rules = {0, 1, 1, 1, 1, 0, 0, 0};

// Rule 90 - Fractal / Triángulo de Sierpinski
int[] rules = {0, 1, 0, 1, 1, 0, 1, 0};

// Rule 110 - Complejidad y estructuras móviles
// int[] rules = {0, 1, 1, 0, 1, 1, 1, 0};

// Rule 150 - Fractal
// int[] rules = {1, 0, 0, 1, 0, 1, 1, 0};

// Rule 184 - Tráfico / Movimiento
// int[] rules = {0, 0, 0, 1, 1, 0, 1, 1};

// Rule 22 - Patrones complejos
// int[] rules = {0, 1, 1, 0, 1, 0, 0, 0};

// Rule 54 - Comportamiento periódico y estructuras
// int[] rules = {0, 1, 1, 0, 1, 1, 0, 0};

// Rule 126 - Patrones densos
// int[] rules = {0, 1, 1, 1, 1, 1, 1, 0};

// Rule 18 - Estructuras triangulares
// int[] rules = {0, 1, 0, 0, 1, 0, 0, 0};

// Rule 150 - Repetición XOR
// int[] rules = {0, 1, 1, 0, 1, 0, 0, 1};

// ==============================================

int[] frame;
PImage texture;
int w, h;
int currY = 1;

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
    
    for(int x = 0; x < w; x++){    
        float rand = random(0, 1);
        frame[x] = rand > INIT_DEAD_PERCENT ? 1 : 0;
    }
}

void applyRules(int px, int py)
{
    //Identify neighbours
    int b = 0;
    for(int nx = -1; nx <= 1; nx++)
    {
        int x = (((px + nx) % w) + w) % w;  
        int y = (((py - 1) % h) + h) % h;
        int i = y * w + x;
        
        if(frame[i] > 0) {
            b |= 1 << (1 - nx);
        }
    }
    
    int i = py * w + px;
    frame[i] = rules[b];
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
        applyRules(x, currY);
    }
    currY = (((currY + 1) % h) + h) % h;
}