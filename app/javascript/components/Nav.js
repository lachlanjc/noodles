import React from 'react'
import Icon, { CollectionsIcon } from './Icon'

const Logo = () => (
  <svg
    xmlns="http://www.w3.org/2000/svg"
    width={28}
    height={28}
    viewBox="0 0 24 24"
    className="fill-orange"
  >
    <path d="M8.1 13.34l2.83-2.83L3.91 3.5c-1.56 1.56-1.56 4.09 0 5.66l4.19 4.18zm6.78-1.81c1.53.71 3.68.21 5.27-1.38 1.91-1.91 2.28-4.65.81-6.12-1.46-1.46-4.2-1.1-6.12.81-1.59 1.59-2.09 3.74-1.38 5.27L3.7 19.87l1.41 1.41L12 14.41l6.88 6.88 1.41-1.41L13.41 13l1.47-1.47z" />
  </svg>
)

const Nav = ({ active = 'recipes', referer = null }) => (
  <nav
    role="navigation"
    className="nav nav--tabs bg-blur phl-ns tc dn-p"
    data-behavior="nav"
  >
    {(_.startsWith(referer, '/recipes') ||
      _.startsWith(referer, '/explore') ||
      _.startsWith(referer, '/collections') ||
      _.startsWith(referer, '/groceries')) ? (
        <a
          className="bg-grey-5 orange circle p1 dn dib-ns"
          aria-label="Back"
          href={referer}
        >
          <Icon glyph="enter" style={{ transform: 'rotate(180deg)' }} />
        </a>
      ) : (
        <a className="nav__icon dn dib-ns" aria-label="Homepage" href="/">
          <Logo />
        </a>
      )}
    <article className="nav__container">
      <a
        className="nav__tab"
        href="/recipes"
        aria-current={active === 'recipes'}
      >
        <Icon glyph="home" />
        <span>Recipes</span>
      </a>
      <a
        className="nav__tab"
        href="/explore"
        aria-current={active === 'explore'}
      >
        <Icon glyph="explore" />
        <span>Explore</span>
      </a>
      <a
        className="nav__tab"
        href="/collections"
        aria-current={active === 'collections'}
      >
        <CollectionsIcon />
        <span>Collections</span>
      </a>
      <a
        className="nav__tab"
        href="/groceries"
        aria-current={active === 'groceries'}
      >
        <Icon glyph="pin" />
        <span>Groceries</span>
      </a>
    </article>
    <action
      type="button"
      className="nav__icon dib menu__toggle"
      data-behavior="menu_toggle"
      aria-expanded={false}
      tabIndex={0}
    >
      <Icon glyph="settings" className="bg-grey-5 grey-3 p1 circle" />
      <popmenu className="menu__content" data-behavior="menu_content">
        <a className="menu__action" href="/my/settings">
          <Icon glyph="settings" />
          <span>My Settings</span>
        </a>
        <a className="menu__action" href="https://news.getnoodl.es/">
          <Icon glyph="notification" />
          <span>News</span>
        </a>
        <a className="menu__action" href="/sign_out">
          <Icon glyph="door-leave" />
          <span>Sign Out</span>
        </a>
      </popmenu>
    </action>
  </nav>
)

export default Nav
