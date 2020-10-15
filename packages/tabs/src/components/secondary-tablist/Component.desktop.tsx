import React from 'react';
import { SecondaryTabList } from './Component';
import { SecondaryTabListProps } from '../../typings';

import commonStyles from './index.module.css';

export type SecondaryTabListDesktopProps = Omit<SecondaryTabListProps, 'tagSize'>;

export const SecondaryTabListDesktop = ({
    size = 'm',
    ...restProps
}: SecondaryTabListDesktopProps) => (
    <SecondaryTabList
        {...restProps}
        size={size}
        styles={commonStyles}
        tagSize={size === 's' ? 'xs' : 's'}
    />
);
