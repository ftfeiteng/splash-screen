import { WebPlugin } from '@capacitor/core';
import type { HideOptions, ShowOptions, SplashScreenPlugin, UpdateProgressOptions } from './definitions';
export declare class SplashScreenWeb extends WebPlugin implements SplashScreenPlugin {
    show(_options?: ShowOptions): Promise<void>;
    updateProgress(_options?: UpdateProgressOptions): Promise<void>;
    hide(_options?: HideOptions): Promise<void>;
}
