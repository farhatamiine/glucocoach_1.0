import logoAsset from '@/public/assets/logo/gluco-coach-icon.png';
import Image from 'next/image';
import type { SVGAttributes } from 'react';

const Logo = (props: SVGAttributes<SVGElement>) => {
    return (
        <div className="flex items-center justify-center pt-4">
            <Image src={logoAsset} width={150} height={40} alt="logo glucocoach" />
        </div>
    );
};

export default Logo;
